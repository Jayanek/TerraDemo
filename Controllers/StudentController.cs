using Microsoft.AspNetCore.Mvc;

namespace TerraCope.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class StudentController : ControllerBase
    {
       

        private readonly ILogger<WeatherForecastController> _logger;

        public StudentController(ILogger<WeatherForecastController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetStudents")]
        public IEnumerable<string> Get()
        {
           return new List<string>(){"Hello","world"};
        }
    }
}