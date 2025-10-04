using Domain.Entities.App;
using Domain.Entities.Categories;
using Domain.Entities.Feedback;
using Domain.Entities.Foods;
using Domain.Entities.Orders;
using Domain.Entities.Users;
using Microsoft.EntityFrameworkCore;

namespace Application.Common.Interfaces;

public interface IDatabaseContext
{
    #region App

    DbSet<ContactMessage> ContactMessages { get; set; }
     DbSet<FeatureItem> FeatureItems { get; set; }
     DbSet<InfoContent> InfoContents { get; set; }
     DbSet<Setting> Settings { get; set; }
    DbSet<Slider> Sliders { get; set; }

    #endregion

    #region Categories

    DbSet<Category> Categories { get; set; }
    DbSet<FoodCategory> FoodCategories { get; set; }

    #endregion

    #region Feedback

    DbSet<Favorite> Favorites { get; set; }
    DbSet<Rating> Ratings { get; set; }
    DbSet<Comment> Comments { get; set; }

    #endregion

    #region Foods

    DbSet<Branch> Branch { get; set; }
    DbSet<Food> Foods { get; set; }
    DbSet<FoodType> FoodTypes { get; set; }

    #endregion

    #region Orders

    DbSet<Order> Orders { get; set; }
    DbSet<OrderItem> OrderItems { get; set; }
    DbSet<Discount> Discounts { get; set; }
        
    #endregion

    #region Users

    DbSet<Address> Addresses { get; set; }

    #endregion

    int SaveChanges();
    int SaveChanges(bool acceptAllChangesOnSuccess);
    Task<int> SaveChangesAsync(bool acceptAllChangesOnSuccess, CancellationToken cancellationToken = default);
    Task<int> SaveChangesAsync(CancellationToken cancellationToken = new CancellationToken());


}