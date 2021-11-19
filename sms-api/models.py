from pydantic import BaseModel

class SMS(BaseModel):
    phone_number: str
    message: str

    def __str__(self) -> str:
        return {
            'phone_number': self.phone_number,
            'message': self.message,
        }
