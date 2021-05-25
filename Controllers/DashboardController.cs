using ASP_TEMPLATE.Models;

using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Diagnostics;

namespace ASP_TEMPLATE.Controllers
{
    public class DashboardController : Controller
    {

        private List<TableModels> models = new List<TableModels>();
        public DashboardController()
        {
           
            for(int i = 0; i <= 100; i++)
            {
                models.Add(new TableModels
                {
                    Name = $"TESTING:{i}",
                    Email = $"Rupit22{i}@gmail.com",
                    City = "Moscow",
                    Phone = "1488-228",
                    Status = Status.Active,

                });
            }
          
        }
        // Главная ссылка - Dashboard
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult Alert()
        {
            return View("Сomponent-alert");
        }
        public IActionResult Badge()
        {
            return View("Component-badge");
        }
        public IActionResult Breadcrumb()
        {
            return View("Component-breadcrumb");
        }

        public IActionResult DataTable()
        {
            return View("DataTable", models);
        }

        // В случае ошибки redirect - ErrorView 
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
