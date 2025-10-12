using Application.Common.Interfaces;
using Domain.Entities.App;
using Domain.Entities.Categories;
using Domain.Entities.Feedback;
using Domain.Entities.Foods;
using Domain.Entities.Orders;
using Domain.Entities.Users;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Persistence.Context;

public class DatabaseContext(DbContextOptions<DatabaseContext> options) : IdentityDbContext<User, Role, Guid>(options) , IDatabaseContext
{


    #region App

    public DbSet<ContactMessage> ContactMessages  { get; set; }
    public DbSet<FeatureItem> FeatureItems { get; set; }
    public DbSet<InfoContent> InfoContents { get; set; }
    public DbSet<Setting> Settings { get; set; }
    public DbSet<Slider> Sliders { get; set; }

    #endregion

    #region Categories

    public DbSet<Category> Categories { get; set; }
    public DbSet<FoodCategory> FoodCategories { get; set; }

    #endregion

    #region Feedback

    public DbSet<Favorite> Favorites { get; set; }
    public DbSet<Rating> Ratings { get; set; }
    public DbSet<Comment> Comments { get; set; }
    #endregion

    #region Foods

    public DbSet<Branch> Branch { get; set; }
    public DbSet<Food> Foods { get; set; }
    public DbSet<FoodType> FoodTypes { get; set; }

    #endregion

    #region Orders

    public DbSet<Order> Orders { get; set; }
    public DbSet<OrderItem> OrderItems { get; set; }
    public DbSet<Discount> Discounts { get; set; }

    #endregion

    #region Users

    public DbSet<Address> Addresses { get; set; }

    #endregion

    #region Setting

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        // Rename Identity tables
        builder.Entity<User>(entity => { entity.ToTable(name: "Users"); });
        builder.Entity<Role>(entity => { entity.ToTable(name: "Roles"); });
        builder.Entity<IdentityUserRole<Guid>>(entity => { entity.ToTable("UserRoles"); });
        builder.Entity<IdentityUserClaim<Guid>>(entity => { entity.ToTable("UserClaims"); });
        builder.Entity<IdentityUserLogin<Guid>>(entity => { entity.ToTable("UserLogins"); });
        builder.Entity<IdentityRoleClaim<Guid>>(entity => { entity.ToTable("RoleClaims"); });
        builder.Entity<IdentityUserToken<Guid>>(entity => { entity.ToTable("UserTokens"); });



        foreach (var relationship in builder.Model.GetEntityTypes()
                     .SelectMany(e => e.GetForeignKeys()))
        {
            relationship.DeleteBehavior = DeleteBehavior.NoAction; // یا DeleteBehavior.NoAction
        }
    }

    #endregion
}