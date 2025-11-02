using Domain.Entities.Categories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Persistence.EntityConfigurations;

public class CategoryConfiguration : IEntityTypeConfiguration<Category>
{
    public void Configure(EntityTypeBuilder<Category> builder)
    {
        builder.HasOne(c => c.FoodType)
            .WithMany(ft => ft.Categories)
            .HasForeignKey(c => c.FoodTypeId)
            .OnDelete(DeleteBehavior.NoAction);
    }
}