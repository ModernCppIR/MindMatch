#include "StoryGameSession.h"

#include <QDebug>

StoryGameSession::StoryGameSession(QObject *parent)
	: QAbstractListModel{parent}
	, roleVector{CustomRolesEnum::Context, CustomRolesEnum::IsSelected, CustomRolesEnum::IsCorrect}
{
	connect(&sessionTimer, &QTimer::timeout, this,
			[this]
			{
				if (remainingTime() > 1)
				{
					setRemainingTime(remainingTime() - 0.1);
				}
			});
}

QString StoryGameSession::sessionName() const
{
	return m_sessionName;
}

void StoryGameSession::setSessionName(const QString &newSessionName)
{
	if (m_sessionName == newSessionName)
		return;
	m_sessionName = newSessionName;
	emit sessionNameChanged();
}

int StoryGameSession::starCount() const
{
	return m_starCount;
}

void StoryGameSession::setStarCount(int newStarCount)
{
	if (m_starCount == newStarCount)
		return;
	m_starCount = newStarCount;
	emit starCountChanged();
}

int StoryGameSession::totalQuestionsCount() const
{
	return m_totalQuestionsCount;
}

void StoryGameSession::setTotalQuestionsCount(int newTotalQuestionsCount)
{
	if (m_totalQuestionsCount == newTotalQuestionsCount)
		return;
	m_totalQuestionsCount = newTotalQuestionsCount;
	emit totalQuestionsCountChanged();
}

int StoryGameSession::currentQuestion() const
{
	return m_currentQuestion;
}

void StoryGameSession::setCurrentQuestion(int newCurrentQuestion)
{
	if (m_currentQuestion == newCurrentQuestion)
		return;
	m_currentQuestion = newCurrentQuestion;
	emit currentQuestionChanged();
}

bool StoryGameSession::muted() const
{
	return m_muted;
}

void StoryGameSession::setMuted(bool newMuted)
{
	if (m_muted == newMuted)
		return;
	m_muted = newMuted;
	emit mutedChanged();
}

void StoryGameSession::gotoNextQuestion()
{
	if (m_currentQuestion < m_questions.size() - 1)
	{
		setCurrentQuestion(currentQuestion() + 1);
		setQuestionString(m_questions[m_currentQuestion].title);
	}
	else
	{
		emit successed();
	}

	emit dataChanged(createIndex(0, 0), createIndex(3, 0), roleVector);
}

void StoryGameSession::answerSelected(int index)
{
	m_questions[m_currentQuestion].answers[index].isSelected = true;

	if (!m_questions[m_currentQuestion].answers[index].isCorrect)
	{
		setStarCount(m_starCount - 1);
		if (m_starCount == 0)
		{
			emit failed();
		}
	}

	emit dataChanged(createIndex(index, 0), createIndex(index, 0), {IsSelected});
}

void StoryGameSession::restartSession()
{
	setCurrentQuestion(0);
	setQuestionString(m_questions[0].title);
	setStarCount(3);

	for (auto &q : m_questions)
	{
		for (auto &a : q.answers)
		{
			a.isSelected = false;
		}
	}
	emit dataChanged(createIndex(0, 0), createIndex(4, 0), {IsSelected});
}

void StoryGameSession::setQuestions(const QVector<StringQuestion> &newQuestions)
{
	m_questions = newQuestions;
	setCurrentQuestion(0);
	setQuestionString(m_questions[0].title);
	setTotalQuestionsCount(m_questions.size());

	emit dataChanged(createIndex(0, 0), createIndex(m_questions.size(), 0), roleVector);
}

void StoryGameSession::start()
{
	sessionTimer.start(100);
}

void StoryGameSession::leaveMatch()
{
	sessionTimer.stop();
	setCurrentQuestion(0);
	setRemainingTime(100);
}

int StoryGameSession::rowCount(const QModelIndex &parent) const
{
	return 4;
}

QVariant StoryGameSession::data(const QModelIndex &index, int role) const
{
	QVariant ret;
	int row = index.row();

	switch (role)
	{
	case CustomRolesEnum::Context:
		ret = m_questions[m_currentQuestion].answers[row].context;

		break;
	case CustomRolesEnum::IsSelected:
		ret = m_questions[m_currentQuestion].answers[row].isSelected;
		break;
	case CustomRolesEnum::IsCorrect:
		ret = m_questions[m_currentQuestion].answers[row].isCorrect;
		break;
	default:

		break;
	}

	return ret;
}

QHash<int, QByteArray> StoryGameSession::roleNames() const
{
	auto roleNamesMap = QAbstractListModel::roleNames();

	roleNamesMap[Context] = "context";
	roleNamesMap[IsSelected] = "isSelected";
	roleNamesMap[IsCorrect] = "isCorrect";

	return roleNamesMap;
}

QString StoryGameSession::questionString() const
{
	return m_questionString;
}

void StoryGameSession::setQuestionString(const QString &newQuestionString)
{
	if (m_questionString == newQuestionString)
		return;
	m_questionString = newQuestionString;
	emit questionStringChanged();
}

double StoryGameSession::remainingTime() const
{
	return m_remainingTime;
}

void StoryGameSession::setRemainingTime(double newRemainingTime)
{
	if (qFuzzyCompare(m_remainingTime, newRemainingTime))
		return;
	m_remainingTime = newRemainingTime;
	emit remainingTimeChanged();
}
