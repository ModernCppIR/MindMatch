#include "Statistics.h"

Statistics::Statistics(QObject *parent)
	: QObject{parent}
{
}

double Statistics::totalStoryScore() const
{
	return m_totalStoryScore;
}

void Statistics::setTotalStoryScore(double newTotalStoryScore)
{
	if (qFuzzyCompare(m_totalStoryScore, newTotalStoryScore))
		return;
	m_totalStoryScore = newTotalStoryScore;
	emit totalStoryScoreChanged();
}

int Statistics::storyLevel() const
{
	return m_storyLevel;
}

void Statistics::setStoryLevel(int newStoryLevel)
{
	if (m_storyLevel == newStoryLevel)
		return;
	m_storyLevel = newStoryLevel;
	emit storyLevelChanged();
}

double Statistics::scoreToNextLevel() const
{
	return m_scoreToNextLevel;
}

void Statistics::setScoreToNextLevel(double newScoreToNextLevel)
{
	if (qFuzzyCompare(m_scoreToNextLevel, newScoreToNextLevel))
		return;
	m_scoreToNextLevel = newScoreToNextLevel;
	emit scoreToNextLevelChanged();
}

int Statistics::totalStoryStarsCount() const
{
	return m_totalStoryStarsCount;
}

void Statistics::setTotalStoryStarsCount(int newTotalStoryStarsCount)
{
	if (m_totalStoryStarsCount == newTotalStoryStarsCount)
		return;
	m_totalStoryStarsCount = newTotalStoryStarsCount;
	emit totalStoryStarsCountChanged();
}

int Statistics::accivedStoryStars() const
{
	return m_accivedStoryStars;
}

void Statistics::setAccivedStoryStars(int newAccivedStoryStars)
{
	if (m_accivedStoryStars == newAccivedStoryStars)
		return;
	m_accivedStoryStars = newAccivedStoryStars;
	emit accivedStoryStarsChanged();
}
