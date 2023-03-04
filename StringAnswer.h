#ifndef STRINGANSWER_H
#define STRINGANSWER_H

#include <QString>

struct StringAnswer
{
	QString context;
	bool isCorrect = 0;
	bool isSelected = 0;
};

#endif // STRINGANSWER_H
