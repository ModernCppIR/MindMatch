#ifndef STRINGQUESTIONANSWER_H
#define STRINGQUESTIONANSWER_H

#include <array>
#include <QString>

#include "StringAnswer.h"

struct StringQuestionAnswer
{
	QString question;

	std::array<StringAnswer, 4> answers;
};

#endif // STRINGQUESTIONANSWER_H
