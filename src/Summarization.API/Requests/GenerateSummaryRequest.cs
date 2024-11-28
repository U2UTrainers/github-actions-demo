namespace Summarization_API.Requests;

public class GenerateSummaryRequest
{
  public int MaxNrOfWords { get; set; }
  public string Content { get; set; } = default!;
}
