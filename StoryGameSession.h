#ifndef STORYGAMESESSION_H
#define STORYGAMESESSION_H

#include "StringQuestionAnswer.h"

#include <QAbstractListModel>
#include <QTimer>

class StoryGameSession : public QAbstractListModel
{
	Q_OBJECT

	Q_PROPERTY(QString sessionName READ sessionName WRITE setSessionName NOTIFY sessionNameChanged)
	Q_PROPERTY(int starCount READ starCount WRITE setStarCount NOTIFY starCountChanged)
	Q_PROPERTY(int currentQuestion READ currentQuestion WRITE setCurrentQuestion NOTIFY
				   currentQuestionChanged)
	Q_PROPERTY(int totalQuestionsCount READ totalQuestionsCount WRITE setTotalQuestionsCount NOTIFY
				   totalQuestionsCountChanged)
	Q_PROPERTY(bool muted READ muted WRITE setMuted NOTIFY mutedChanged)

	Q_PROPERTY(QString questionString READ questionString WRITE setQuestionString NOTIFY
				   questionStringChanged)

	Q_PROPERTY(
		double remainingTime READ remainingTime WRITE setRemainingTime NOTIFY remainingTimeChanged)
public:
	explicit StoryGameSession(QObject *parent = nullptr);

	enum CustomRolesEnum
	{
		Context = Qt::UserRole + 1,
		IsSelected,
		IsCorrect
	};

	QString sessionName() const;
	void setSessionName(const QString &newSessionName);

	int starCount() const;
	void setStarCount(int newStarCount);

	int totalQuestionsCount() const;
	void setTotalQuestionsCount(int newTotalQuestionsCount);

	int currentQuestion() const;
	void setCurrentQuestion(int newCurrentQuestion);

	bool muted() const;
	void setMuted(bool newMuted);

public slots:
	void start();
	void leaveMatch();

	void gotoNextQuestion();
	void answerSelected(int index);

signals:

	void successed();
	void failed();

	void sessionNameChanged();
	void starCountChanged();

	void totalQuestionsChanged();

	void totalQuestionsCountChanged();

	void currentQuestionChanged();

	void mutedChanged();

	void questionStringChanged();

	void remainingTimeChanged();

private:
	void createDummyQuestionForTest();

private:
	QString m_sessionName;
	int m_starCount = 3;
	int m_totalQuestionsCount = 0;
	int m_currentQuestion = 0;
	bool m_muted = false;

	QVector<StringQuestionAnswer> m_questions;

	QVector<int> roleVector;

	// QAbstractItemModel interface
	QString m_questionString;

	double m_remainingTime = 100;

	QTimer sessionTimer;

public:
	int rowCount(const QModelIndex &parent) const override;
	QVariant data(const QModelIndex &index, int role) const override;
	QHash<int, QByteArray> roleNames() const override;
	QString questionString() const;
	void setQuestionString(const QString &newQuestionString);
	double remainingTime() const;
	void setRemainingTime(double newRemainingTime);
};

#endif // STORYGAMESESSION_H
