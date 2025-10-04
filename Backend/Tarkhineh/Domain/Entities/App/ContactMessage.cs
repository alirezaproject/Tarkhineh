using Domain.Abstractions;

namespace Domain.Entities.App;

public sealed class ContactMessage : BaseEntity
{
    public string FullName { get; set; }
    public string PhoneNumber { get; set; }
    public string Email { get; set; }
    public string Message { get; set; }
    public DateTime SentAt { get; set; } = DateTime.UtcNow;
}