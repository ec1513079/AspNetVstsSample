using System;
using Xunit;

namespace AspNetVstsSample.Web.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void AspNetVstsSample_Web_FirstTest()
        {
            var result = new AspNetVstsSample.Web.Models.Sample()
            {
                Id = 1,
                Title = "HOGEHOGE",
                Detail = "Fugafuga"
            };

            Assert.NotNull(result);
            Assert.Equal(result.Id, 1);
            Assert.Equal(result.Title, "HOGEHOGE");
            Assert.Equal(result.Detail, "Fugafuga");
        }
    }
}
