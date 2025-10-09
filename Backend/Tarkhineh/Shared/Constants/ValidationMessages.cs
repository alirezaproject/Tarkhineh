namespace Shared.Constants;

public static class ValidationMessages
{
    public const string Required = "{PropertyName} را وارد کنید";
    public const string MaxLength = "تعداد کارکتر برای {PropertyName} بیش از حد مجاز می باشد .";
    public const string Email = "لطفا {PropertyName} را با فرمت درست وارد کنید";
    public const string Exist = "{PropertyName} تکراری است . لطفا یک نام دیگری انتخاب کنید";
    public const string MobileNumber = "لطفا {PropertyName} را به صورت 09 وارد کنید";
    public const string MustBePositiveNumber = "لطفا مقدار مثبت وارد کنید";
}