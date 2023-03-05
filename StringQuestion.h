#ifndef STRINGQUESTION_H
#define STRINGQUESTION_H

#include <array>
#include <QString>

#include "StringAnswer.h"

struct StringQuestion
{
	QString title;

	std::array<StringAnswer, 4> answers;
};

#endif // STRINGQUESTION_H
