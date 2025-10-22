namespace Shared.Constants;

public static class ValidationMessages
{
    public const string Required = "{PropertyName} را وارد کنید";
    public const string MaxLength = "تعداد کارکتر برای {PropertyName} بیش از حد مجاز می باشد .";
    public const string Email = "لطفا {PropertyName} را با فرمت درست وارد کنید";
    public const string Exist = "{PropertyName} تکراری است . لطفا یک نام دیگری انتخاب کنید";
    public const string MobileNumber = "لطفا {PropertyName} را به صورت 09 وارد کنید";
    public const string MustBePositiveNumber = "لطفا مقدار مثبت وارد کنید";
    public const string InvalidFormat = "{PropertyName} معتبر نمی باشد";
    public const string GreaterThanZero = "{PropertyName} باید بزرگتر از صفر باشد";
    public const string InvalidRange = "مقدار {PropertyName} خارج از محدوده‌ی مجاز است";
    public const string AtLeastOneItem = "{PropertyName} باید حداقل یک مورد داشته باشد";

}