#include "threadpool.h"
#include "simple_log.h"

const int MAX_TASKS = 4;

void hello(void* arg)
{
  int* x = (int*) arg;
  LOG_INFO("Hello %d", *x);
  delete (int *)arg;
}

int main(int argc, char* argv[])
{
  ThreadPool tp;
  int ret = tp.init(2);
  if (ret == -1) {
    LOG_ERROR("Failed to initialize thread pool!");
    return 0;
  }

  for (int i = 0; i < MAX_TASKS; i++) {
    int* x = new int();
    *x = i+1;
    Task* t = new Task(&hello, (void*) x);
    tp.add_task(t);
  }

  sleep(2);

  tp.destroy_threadpool();

  LOG_INFO("Exiting app...");

  return 0;
}
