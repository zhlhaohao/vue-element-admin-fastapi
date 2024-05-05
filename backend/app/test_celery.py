# import os
# import sys
# file_path = os.path.abspath(__file__)
# workspace_path = os.path.sep.join(file_path.split(os.path.sep)[:-5])
# sys.path.append(workspace_path)

if __name__=="__main__":
    # test_celery_worker_test()
    from app.celery_app.worker.example import test_celery
    import time
    result = test_celery("zhlhao@163.com") #异步调用，这一步不会阻塞，程序会立即往下运行

    while not result.ready():# 循环检查任务是否执行完毕
        print(time.strftime("%H:%M:%S"))
        time.sleep(1)
    