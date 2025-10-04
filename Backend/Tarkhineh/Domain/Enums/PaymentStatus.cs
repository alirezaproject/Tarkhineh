namespace Domain.Enums;

public enum PaymentStatus
{
    Pending = 1,     // در انتظار پرداخت
    Paid = 2,        // پرداخت موفق
    Failed = 3,      // پرداخت ناموفق
    Refunded = 4     // عودت داده شده
}