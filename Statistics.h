#ifndef STATISTICS_H
#define STATISTICS_H

#include <QObject>

class Statistics : public QObject
{
	Q_OBJECT
	Q_PROPERTY(double totalStoryScore READ totalStoryScore WRITE setTotalStoryScore NOTIFY
				   totalStoryScoreChanged)

	Q_PROPERTY(int storyLevel READ storyLevel WRITE setStoryLevel NOTIFY storyLevelChanged)

	Q_PROPERTY(double scoreToNextLevel READ scoreToNextLevel WRITE setScoreToNextLevel NOTIFY
				   scoreToNextLevelChanged)

	Q_PROPERTY(int totalStoryStarsCount READ totalStoryStarsCount WRITE setTotalStoryStarsCount
				   NOTIFY totalStoryStarsCountChanged)

	Q_PROPERTY(int accivedStoryStars READ accivedStoryStars WRITE setAccivedStoryStars NOTIFY
				   accivedStoryStarsChanged)

public:
	explicit Statistics(QObject *parent = nullptr);

	double totalStoryScore() const;
	void setTotalStoryScore(double newTotalStoryScore);

	int storyLevel() const;
	void setStoryLevel(int newStoryLevel);

	double scoreToNextLevel() const;
	void setScoreToNextLevel(double newScoreToNextLevel);

	int totalStoryStarsCount() const;
	void setTotalStoryStarsCount(int newTotalStoryStarsCount);

	int accivedStoryStars() const;
	void setAccivedStoryStars(int newAccivedStoryStars);

signals:

	void totalStoryScoreChanged();

	void storyLevelChanged();

	void scoreToNextLevelChanged();

	void totalStoryStarsCountChanged();

	void accivedStoryStarsChanged();

private:
	double m_totalStoryScore;
	int m_storyLevel;
	double m_scoreToNextLevel;
	int m_totalStoryStarsCount;
	int m_accivedStoryStars;
};

#endif // STATISTICS_H
