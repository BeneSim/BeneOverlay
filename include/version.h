#ifndef VERSION_H
#define VERSION_H

int const VERSION_MAJOR = 1;
int const VERSION_MINOR = 2;
int const VERSION_PATCH = 0;
bool const VERSION_PRERELEASE = true;

QString const VERSION_STRING = VERSION_PRERELEASE ? QString("%1.%2.%3 (Beta)").arg(VERSION_MAJOR).arg(VERSION_MINOR).arg(VERSION_PATCH) : QString("%1.%2.%3").arg(VERSION_MAJOR).arg(VERSION_MINOR).arg(VERSION_PATCH);


#endif // VERSION_H
