#include "DatabaseManager.h"

#include <QDebug>
#include <QtSql>

#include <algorithm>
#include <random>

#include <third_party/picomath.hpp>

DatabaseManager::DatabaseManager(QObject *parent)
	: QObject{parent}
{
}

bool DatabaseManager::open()
{
	bool success{false};
	QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
	qDebug() << db.drivers();
	//	db.setDatabaseName(":memory:");
	db.setDatabaseName("sss");
	if (!db.open())
	{
		//		QMessageBox::critical(nullptr, QObject::tr("Cannot open database"),
		//							  QObject::tr("Unable to establish a database connection.\n"
		//										  "This example needs SQLite support. Please read "
		//										  "the Qt SQL driver documentation for information how "
		//										  "to build it.\n\n"
		//										  "Click Cancel to exit."), QMessageBox::Cancel);
		//		return false;
		qDebug() << "Cannot open database\n"
					"Unable to establish a database connection.\n"
					"This example needs SQLite support. Please read "
					"the Qt SQL driver documentation for information how "
					"to build it.\n\n"
					"Click Cancel to exit.";
	}
	else
	{
		success = true;
	}

	return success;
}

bool DatabaseManager::init()
{
	bool success{false};

	// NOTE create initial database tables and load questiuon database
	QSqlQuery query;
	query.exec("create table questions (id int primary key, "
			   "question text, first_answer text, second_answer text, third_answer text, "
			   "fourth_answer text, correct_answer int, hardness_level int, operators text)");

	// NOTE random querry selection
	// SELECT * FROM table ORDER BY RANDOM() LIMIT 1;

	// +

	// NOTE check question generator

	// TODO load question database
	return success;
}

QVector<ChapterItem> DatabaseManager::getChapter(const QString &operators, int hardnessLevel)
{
	QVector<ChapterItem> items;

	QSqlQuery query("SELECT * FROM questions WHERE operators = '" + operators
					+ "' AND hardness_level = " + QString::number(hardnessLevel)
					+ " ORDER BY RANDOM() LIMIT 10;");

	qDebug() << query.lastQuery();
	qDebug() << query.lastError().text();

	//	"question text, first_answer text, second_answer text, third_answer text, "
	//	"fourth_answer text, correct_answer int, hardness_level int, operators text
	int keyId = query.record().indexOf("key");
	int questionId = query.record().indexOf("question");
	int first_answerId = query.record().indexOf("first_answer");
	int second_answerId = query.record().indexOf("second_answer");
	int third_answerId = query.record().indexOf("third_answer");
	int fourth_answerId = query.record().indexOf("fourth_answer");
	int correct_answerId = query.record().indexOf("correct_answer");
	int operatorsId = query.record().indexOf("operators");

	while (query.next())
	{
		auto id = query.value(keyId).toInt();
		auto question = query.value(questionId).toString();
		auto first_answer = query.value(first_answerId).toString();
		auto second_answer = query.value(second_answerId).toString();
		auto third_answer = query.value(third_answerId).toString();
		auto fourth_answer = query.value(fourth_answerId).toString();
		auto correct_answer = query.value(correct_answerId).toInt();
		auto operators = query.value(operatorsId).toString();
		qDebug() << "id: " << id << "\t"
				 << "question: " << question << "\t"
				 << "first_answer: " << first_answer << "\t"
				 << "second_answer: " << second_answer << "\t"
				 << "third_answer: " << third_answer << "\t"
				 << "fourth_answer: " << fourth_answer << "\t"
				 << "correct_answer: " << correct_answer << "\t"
				 << "operators: " << operators << "\t";
	}

	return items;
}

void DatabaseManager::generateQuestions()
{

	/// [x] 1. (a + b = ?)
	///	[x] 2. (a + ? = b) - (? + a = b)
	///	[x] 3.	? number
	///		[x] a + b
	///		[x] c + d
	///		[x] e + f
	///		[x] g + h
	/// [x] 4. smallest
	/// [x] 5. a + b + c
	/// [x] 6. aa + bb
	/// [x] 7. largest
	/// [ ] 8. a + b
	///		[ ] c + d
	///		[ ] e + f
	///		[ ] g + h
	///		[ ] i + j
	/// [ ] 9. mix
	///
	QSqlQuery query;
	// NOTE math
	using namespace picomath;

	PicoMath pm;

	int counter{0};

	auto addQuestion = [&query](int id, const QString &question, const QString &first_answer,
								const QString &second_answer, const QString &third_answer,
								const QString &fourth_answer, int correct_answer,
								int hardness_level, const QString &operators)
	{
		/*qDebug() <<*/ query.exec(
			QString("insert into questions values(%1, '%2', '%3', '%4', '%5', '%6', %7, %8, '%9')")
				.arg(QString::number(id), question, first_answer, second_answer, third_answer,
					 fourth_answer, QString::number(correct_answer),
					 QString::number(hardness_level), operators));

		//		qDebug() << "lastQuery: " << query.lastQuery();
		//		qDebug() << query.lastError().text();
	};

	auto rd = std::random_device{};
	auto rng = std::default_random_engine{rd()};

	auto makeUnique = [&rng](std::vector<QString> &answers_vec, int range = 10)
	{
		std::sort(answers_vec.begin(), answers_vec.end());
		auto last = std::unique(answers_vec.begin(), answers_vec.end());
		bool is_unique = (last == answers_vec.end());
		if (!is_unique)
		{
			for (; last != answers_vec.end(); last = std::next(last))
			{
				QString newNumber{"0"};

				bool repetitive{true};

				do
				{
					newNumber = QString::number(QRandomGenerator::global()->generate() % range);
					auto it = std::find(answers_vec.begin(), answers_vec.end(), newNumber);
					repetitive = it != answers_vec.end();

				} while (repetitive);

				*last = newNumber;
			}

			last = std::unique(answers_vec.begin(), answers_vec.end());

			if (last != answers_vec.end())
			{
				qDebug() << "makeUnique dose not work";
				throw std::runtime_error("makeUnique dose not work");
			}
		}
	};

	auto makeShuffle = [&rng](std::vector<QString> &answers_vec)
	{ std::shuffle(std::begin(answers_vec), std::end(answers_vec), rng); };

	// NOTE + level one questions
	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{
			std::vector<QString> answers_vec(4);

			answers_vec[0] = QString::number(i + j);
			answers_vec[1] = QString::number(std::abs(i - j));
			answers_vec[2] = QString::number(i * j);
			answers_vec[3] = QString::number(QRandomGenerator::global()->generate() % 10 + 1);

			makeUnique(answers_vec);
			makeShuffle(answers_vec);

			addQuestion(++counter,
						QString("%1 + %2 = ?").arg(QString::number(i), QString::number(j)),
						answers_vec[0], answers_vec[1], answers_vec[2], answers_vec[3],
						std::distance(answers_vec.begin(),
									  std::find(answers_vec.begin(), answers_vec.end(),
												QString::number(i + j))
										  + 1),
						1, "+");
		}
	}

	// NOTE + level two questions series 1
	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{
			std::vector<QString> answers_vec(4);

			answers_vec[0] = QString::number(j);
			answers_vec[1] = QString::number(std::abs(i - j));
			answers_vec[2] = QString::number(i * j);
			answers_vec[3] = QString::number(QRandomGenerator::global()->generate() % 10);

			makeUnique(answers_vec);
			makeShuffle(answers_vec);

			addQuestion(++counter,
						QString("%1 + ? = %2").arg(QString::number(i), QString::number(i + j)),
						answers_vec[0], answers_vec[1], answers_vec[2], answers_vec[3],
						std::distance(answers_vec.begin(),
									  std::find(answers_vec.begin(), answers_vec.end(),
												QString::number(j)))
							+ 1,
						2, "+");
		}
	}

	// NOTE + level two questions series 2
	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{
			std::vector<QString> answers_vec(4);

			answers_vec[0] = QString::number(j);
			answers_vec[1] = QString::number(std::abs(i - j));
			answers_vec[2] = QString::number(i * j);

			do
			{
				answers_vec[3] = QString::number(QRandomGenerator::global()->generate() % 10);
			} while (answers_vec[3] == QString::number(i + j));

			makeUnique(answers_vec);
			makeShuffle(answers_vec);

			addQuestion(++counter,
						QString("? + %1 = %2").arg(QString::number(i), QString::number(i + j)),
						answers_vec[0], answers_vec[1], answers_vec[2], answers_vec[3],
						std::distance(answers_vec.begin(),
									  std::find(answers_vec.begin(), answers_vec.end(),
												QString::number(j)))
							+ 1,
						2, "+");
		}
	}

	// NOTE + level three questions

	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{

			std::vector<QString> answers_vec(4);

			auto answer = QString("%1 + %2").arg(QString::number(i), QString::number(j));
			answers_vec[0] = answer;

			int newJ{0};
			while (newJ == 0)
			{
				newJ = QRandomGenerator::global()->generate() % 10;
			}

			answers_vec[1] = QString("%1 + %2").arg(QString::number(i),
													QString::number(j != 0 ? i / j : newJ));
			answers_vec[2] = QString("%1 + %2").arg(QString::number(i + j), QString::number(j));
			answers_vec[3] = QString("%1 + %2").arg(QString::number(i + 1),
													QString::number(std::abs(j - 2)));

			// NOTE check if expressions result is same as correct answer
			// TODO check if expresions are equal

			auto checkAnswer = [&answers_vec, &pm, i, j](QString &a) -> bool
			{
				auto result = pm.evalExpression(a.toStdString().c_str());
				if (result.isOk())
				{
					double r = result.getResult();

					if (i + j == r)
					{
						a = QString("%1 + %2")
								.arg(QString::number(QRandomGenerator::global()->generate() % 10),
									 QString::number(QRandomGenerator::global()->generate() % 10));
						return false;
					}
					else
					{
						return true;
					}
				}
				else
				{
					throw std::runtime_error("error in expression: " + a.toStdString());
				}
			};

			while (!checkAnswer(answers_vec[1]))
				;
			while (!checkAnswer(answers_vec[2]))
				;
			while (!checkAnswer(answers_vec[3]))
				;

			makeShuffle(answers_vec);

			addQuestion(++counter, QString::number(i + j), answers_vec[0], answers_vec[1],
						answers_vec[2], answers_vec[3],
						std::distance(answers_vec.begin(),
									  std::find(answers_vec.begin(), answers_vec.end(), answer))
							+ 1,
						3, "+");
		}
	}

	// NOTE + level 4 questions smallest
	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{

			std::vector<QString> answers_vec(4);

			int newJ{0};
			while (newJ == 0)
			{
				newJ = QRandomGenerator::global()->generate() % 10;
			}

			answers_vec[0] = QString("%1 + %2").arg(QString::number(i),
													QString::number(j != 0 ? i / j : newJ));
			answers_vec[1] = QString("%1 + %2").arg(QString::number(i),
													QString::number(j != 0 ? i / j : newJ));
			answers_vec[2] = QString("%1 + %2").arg(QString::number(i + j), QString::number(j));
			answers_vec[3] = QString("%1 + %2").arg(QString::number(i + 1),
													QString::number(std::abs(j - 2)));

			// NOTE check if expressions result is same as correct answer
			// TODO check if expresions are equal

			auto checkAnswer = [&answers_vec, &pm, i, j](size_t index) -> bool
			{
				auto result = pm.evalExpression(answers_vec[index].toStdString().c_str());
				if (result.isOk())
				{
					double r = result.getResult();

					for (size_t i{0}; i < 4; ++i)
					{
						if (i == index)
						{
							continue;
						}

						auto result = pm.evalExpression(answers_vec[i].toStdString().c_str());
						if (result.isOk())
						{
							double ir = result.getResult();
							if (r == ir)
							{
								answers_vec[index] = QString("%1 + %2").arg(
									QString::number(QRandomGenerator::global()->generate() % 10),
									QString::number(QRandomGenerator::global()->generate() % 10));
								return false;
							}
						}
						else
						{
							throw std::runtime_error("error in expression: "
													 + answers_vec[i].toStdString());
						}
					}
					return true;
				}
				else
				{
					throw std::runtime_error("error in expression: "
											 + answers_vec[index].toStdString());
				}
				return false;
			};

			while (!checkAnswer(1))
				;
			while (!checkAnswer(2))
				;
			while (!checkAnswer(3))
				;

			makeShuffle(answers_vec);

			auto min_element
				= std::min_element(answers_vec.cbegin(), answers_vec.cend(),
								   [&pm](const QString &f, const QString &s)
								   {
									   auto fResult = pm.evalExpression(f.toStdString().c_str());
									   auto sResult = pm.evalExpression(s.toStdString().c_str());
									   if (fResult.isOk() && sResult.isOk())
									   {
										   double fr = fResult.getResult();
										   double sr = sResult.getResult();

										   return fr < sr;
									   }
									   else
									   {
										   throw std::runtime_error("error in expression: "
																	+ f.toStdString() + " "
																	+ s.toStdString());
									   }
								   });

			addQuestion(++counter, tr("کوچک ترین"), answers_vec[0], answers_vec[1], answers_vec[2],
						answers_vec[3], std::distance(answers_vec.cbegin(), min_element) + 1, 4,
						"+");
		}
	}

	//	// NOTE + level 5 questions a + b + c

	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{
			for (int k{0}; k < 10; ++k)
			{
				std::vector<QString> answers_vec(4);

				answers_vec[0] = QString::number(i + j + k);
				answers_vec[1] = QString::number(((i * j * k) / 3) * 2);
				answers_vec[2] = QString::number(i * j);
				answers_vec[3] = QString::number(i * j + k);

				makeUnique(answers_vec);
				makeShuffle(answers_vec);

				addQuestion(++counter,
							QString("%1 + %2 + %3 = ")
								.arg(QString::number(i), QString::number(j), QString::number(k)),
							answers_vec[0], answers_vec[1], answers_vec[2], answers_vec[3],
							std::distance(answers_vec.begin(),
										  std::find(answers_vec.begin(), answers_vec.end(),
													QString::number(j)))
								+ 1,
							5, "+");
			}
		}
	}

	// NOTE + level 6 questions aa + bb
	for (int i{0}; i < 100; ++i)
	{
		for (int j{0}; j < 100; ++j)
		{
			if (QRandomGenerator::global()->generate() % 3 == 0)
			{
				std::vector<QString> answers_vec(4);

				answers_vec[0] = QString::number(i + j);
				answers_vec[1] = QString::number(std::abs(i - j));
				answers_vec[2] = QString::number(i * j);
				answers_vec[3] = QString::number(QRandomGenerator::global()->generate() % 100);

				makeUnique(answers_vec);
				makeShuffle(answers_vec);

				addQuestion(++counter,
							QString("%1 + %2 = ?").arg(QString::number(i), QString::number(j)),
							answers_vec[0], answers_vec[1], answers_vec[2], answers_vec[3],
							std::distance(answers_vec.begin(),
										  std::find(answers_vec.begin(), answers_vec.end(),
													QString::number(i + j))
											  + 1),
							6, "+");
			}
		}
	}

	// NOTE + level 7 questions largest
	for (int i{0}; i < 10; ++i)
	{
		for (int j{0}; j < 10; ++j)
		{

			std::vector<QString> answers_vec(4);

			int newJ{0};
			while (newJ == 0)
			{
				newJ = QRandomGenerator::global()->generate() % 10;
			}

			answers_vec[0] = QString("%1 + %2").arg(QString::number(i),
													QString::number(j != 0 ? i / j : newJ));
			answers_vec[1] = QString("%1 + %2").arg(QString::number(i),
													QString::number(j != 0 ? i / j : newJ));
			answers_vec[2] = QString("%1 + %2").arg(QString::number(i + j), QString::number(j));
			answers_vec[3] = QString("%1 + %2").arg(QString::number(i + 1),
													QString::number(std::abs(j - 2)));

			// NOTE check if expressions result is same as correct answer
			// TODO check if expresions are equal

			auto checkAnswer = [&answers_vec, &pm, i, j](size_t index) -> bool
			{
				auto result = pm.evalExpression(answers_vec[index].toStdString().c_str());
				if (result.isOk())
				{
					double r = result.getResult();

					for (size_t idx{0}; idx < 4; ++idx)
					{
						if (idx == index)
						{
							continue;
						}

						auto result = pm.evalExpression(answers_vec[idx].toStdString().c_str());
						if (result.isOk())
						{
							double ir = result.getResult();
							if (r == ir)
							{
								answers_vec[index] = QString("%1 + %2").arg(
									QString::number(QRandomGenerator::global()->generate() % 10),
									QString::number(QRandomGenerator::global()->generate() % 10));
								return false;
							}
						}
						else
						{
							throw std::runtime_error("error in expression: "
													 + answers_vec[idx].toStdString());
						}
					}

					return true;
				}
				else
				{
					throw std::runtime_error("error in expression: "
											 + answers_vec[index].toStdString());
				}
				return false;
			};

			while (!checkAnswer(0))
				;
			while (!checkAnswer(1))
				;
			while (!checkAnswer(2))
				;
			while (!checkAnswer(3))
				;

			makeShuffle(answers_vec);

			auto max_element
				= std::max_element(answers_vec.cbegin(), answers_vec.cend(),
								   [&pm](const QString &f, const QString &s)
								   {
									   auto fResult = pm.evalExpression(f.toStdString().c_str());
									   auto sResult = pm.evalExpression(s.toStdString().c_str());
									   if (fResult.isOk() && sResult.isOk())
									   {
										   double fr = fResult.getResult();
										   double sr = sResult.getResult();

										   return fr < sr;
									   }
									   else
									   {
										   throw std::runtime_error("error in expression: "
																	+ f.toStdString() + " "
																	+ s.toStdString());
									   }
								   });

			addQuestion(++counter, tr("بزرگ ترین"), answers_vec[0], answers_vec[1], answers_vec[2],
						answers_vec[3], std::distance(answers_vec.cbegin(), max_element) + 1, 7,
						"+");
		}
	}

	//// NOTE + level 8 questions a + b = c + d

	for (int i{10}; i < 100; ++i)
	{
		for (int j{10}; j < 100; ++j)
		{

			if (QRandomGenerator::global()->generate() % 3 == 0)
			{
				std::vector<QString> answers_vec(4);
				int max = std::max(i, j);
				int min = std::min(i, j);

				int randomNumber = QRandomGenerator::global()->generate() % max;

				// NOTE create correct answer
				QString answer = QString("%1 + %2").arg(QString::number(max - randomNumber),
														QString::number(min + randomNumber));
				answers_vec[0] = answer;

				int newJ{0};
				while (newJ == 0)
				{
					newJ = QRandomGenerator::global()->generate() % 10;
				}

				answers_vec[1] = QString("%1 + %2").arg(QString::number(i),
														QString::number(j != 0 ? i / j : newJ));
				answers_vec[2] = QString("%1 + %2").arg(QString::number(i + j), QString::number(j));
				answers_vec[3] = QString("%1 + %2").arg(QString::number(i + 1),
														QString::number(std::abs(j - 2)));

				// NOTE check if expressions result is same as correct answer
				// TODO check if expresions are equal

				auto checkAnswer = [&answers_vec, &pm, i, j](QString &a) -> bool
				{
					auto result = pm.evalExpression(a.toStdString().c_str());
					if (result.isOk())
					{
						double r = result.getResult();

						if (i + j == r)
						{
							a = QString("%1 + %2").arg(
								QString::number(QRandomGenerator::global()->generate() % 10),
								QString::number(QRandomGenerator::global()->generate() % 10));
							return false;
						}
						else
						{
							return true;
						}
					}
					else
					{
						throw std::runtime_error("error in expression: " + a.toStdString());
					}
				};

				while (!checkAnswer(answers_vec[1]))
					;
				while (!checkAnswer(answers_vec[2]))
					;
				while (!checkAnswer(answers_vec[3]))
					;

				makeShuffle(answers_vec);

				addQuestion(++counter,
							QString("%1 + %2").arg(QString::number(i), QString::number(j)),
							answers_vec[0], answers_vec[1], answers_vec[2], answers_vec[3],
							std::distance(answers_vec.begin(),
										  std::find(answers_vec.begin(), answers_vec.end(), answer))
								+ 1,
							8, "+");
			}
		}
	}
}
