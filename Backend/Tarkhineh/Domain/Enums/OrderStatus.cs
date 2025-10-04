namespace Domain.Enums;

public enum OrderStatus
{
    Pending = 1,      // ثبت شده ولی هنوز تایید یا پردازش نشده
    Processing = 2,   // در حال آماده‌سازی
    Shipped = 3,      // ارسال شده (در مسیر)
    Delivered = 4,    // تحویل مشتری شده
    Cancelled = 5     // لغو شده
}