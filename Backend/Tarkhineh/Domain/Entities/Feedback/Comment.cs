using Domain.Abstractions;
using Domain.Entities.Foods;

namespace Domain.Entities.Feedback;

public sealed class Comment : BaseEntity
{
    public string Text { get; set; }

    #region Relations

    public Branch Branch { get; set; }
    public Guid BranchId { get; set; }

    #endregion
}