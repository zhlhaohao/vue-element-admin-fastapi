from typing import Any

from fastapi import APIRouter
from pydantic.networks import EmailStr

from app import schemas
from app.celery_app.celery_app import celery_app
from app.extensions.utils import send_test_email

router = APIRouter()

@router.post("/test-celery/", response_model=schemas.Msg, status_code=201)
def test_celery(email: schemas.Email,) -> Any:
    """
    api接口，测试Celery worker -- 调用 app.celery_app.worker.example.test_celery 任务
    """
    result = celery_app.send_task("app.celery_app.worker.example.test_celery", args=[email.email])
    # result.get()
    return {"msg": "Word received"}


@router.post("/test-email/", response_model=schemas.Msg, status_code=201)
def test_email(email_to: EmailStr,) -> Any:
    """
    Test emails.
    """
    send_test_email(email_to=email_to)
    return {"msg": "Test email sent"}
