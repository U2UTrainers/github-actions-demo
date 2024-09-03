namespace Summarization_API.Responses;

public class GenerateSummaryResponse
{
  public string Title { get; set; } = default!;
  public string Content { get; set; } = default!;
  public string Summary { get; set; } = default!;
}
