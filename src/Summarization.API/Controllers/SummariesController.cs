using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.SemanticKernel;
using Summarization_API.Requests;
using Summarization_API.Responses;
using Summarization_API.Services;

namespace Summarization_API.Controllers;
[Route("api/[controller]")]
[ApiController]
public class SummariesController : ControllerBase
{
  private ISummaryService _summaryService;

  public SummariesController(ISummaryService summaryService)
  {
    _summaryService = summaryService;
  }

  [HttpPost]
  public async Task<ActionResult<GenerateSummaryResponse>> CreateSummary(GenerateSummaryRequest request)
  {
    GenerateSummaryResponse response = new GenerateSummaryResponse()
    {
      Content = request.Content
    };

    string? summary = await _summaryService.GenerateSummary(request);

    response.Summary = summary!;

    return response;
  }

  [HttpGet]
  public string GetHelloWorld()
  {
    return "Hello World";
  }
}
