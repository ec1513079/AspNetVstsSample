﻿// <auto-generated />
using AspNetVstsSample.Web.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore.Storage.Internal;
using System;

namespace AspNetVstsSample.Web.Migrations
{
    [DbContext(typeof(AspNetVstsSampleDbContext))]
    partial class AspNetVstsSampleDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.0.1-rtm-125")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("AspNetVstsSample.Web.Models.Sample", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Detail");

                    b.Property<string>("Title");

                    b.HasKey("Id");

                    b.ToTable("Samples");
                });
#pragma warning restore 612, 618
        }
    }
}