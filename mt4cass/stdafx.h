#pragma once
#include "targetver.h"

#define WIN32_LEAN_AND_MEAN             // Исключите редко используемые компоненты из заголовков Windows
#include <windows.h>

#define _DLLAPI extern "C" __declspec(dllexport)
