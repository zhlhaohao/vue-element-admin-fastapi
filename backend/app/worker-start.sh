#指明队列名称
ps -ux|grep 'celery'|grep -v grep|awk '{print $2}'|xargs kill -9
nohup celery -A app.celery_app.worker.example worker -l info -Q example-queue -c 1  > celery.log &


# - `celery`: 这是启动Celery worker的命令。

# - `-A app.celery_app.worker.example`: 
#   - `-A` 或 `--app` 参数指定了Celery应用程序的入口点。这里`app.celery_app.worker.example`意味着Celery将在`app`模块中的`celery_app.worker.example`找到配置和任务。通常，这指的是你的Python模块路径，其中包含了Celery应用的实例。

# - `worker`: 这个关键词告诉Celery你要启动的是一个worker进程，它负责从消息队列中取出并执行任务。

# - `-l info`: 
#   - `-l` 或 `--loglevel` 设置了日志记录的级别。在这个例子中，设置为`info`，意味着worker将会记录信息级别的日志，包括一般操作信息和警告，但不包括调试信息。

# - `-Q example-queue`: 
#   - `-Q` 或 `--queues` 指定了worker将监听的任务队列。在这个命令中，worker只处理名为`example-queue`的任务队列。这意味着只有被发送到`example-queue`的任务会被这个worker接收并执行。

# - `-c 1`: 
#   - `-c` 或 `--concurrency` 设置了worker的并发数，即同时可以处理的任务数量。这里设置为`1`，意味着这个worker一次只会处理一个任务。如果未指定或设置为更高数值，Celery可以根据系统资源和配置自动或手动调整并发数以处理更多任务。
