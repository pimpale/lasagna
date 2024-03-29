#ifndef PARSEABLE_H
#define PARSEABLE_H

#include <stdint.h>
#include <stdio.h>

typedef enum {
  PARSEABLE_BACKING_MEMORY,
  PARSEABLE_BACKING_FILE,
} ParseableBacking;

/* Do not manually modify any of these values  */

typedef struct {
  FILE* file;
  char* memory;
  size_t len;
  /* location in file */
  size_t loc;
  /* Caches the value of the last char fetched for ungetc */
  int32_t lastVal;
  /* The backing data structure */
  ParseableBacking backing;
} Parseable;

void initParseableFile(Parseable* parseable, FILE* fp);
void initParseableMemory(Parseable* parseable, char* ptr, size_t len);

int32_t nextValue(Parseable* p);
void backValue(Parseable* p);

void freeParseable(Parseable* p);

#endif /* PARSEABLE_H */
