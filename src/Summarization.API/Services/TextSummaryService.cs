
using Microsoft.SemanticKernel;
using Summarization_API.Requests;

namespace Summarization_API.Services;

public class TextSummaryService : ISummaryService
{
  private readonly Kernel _kernel;

  public TextSummaryService(Kernel kernel)
  {
    _kernel = kernel;
  }

  public async Task<string?> GenerateSummary(GenerateSummaryRequest generateSummaryRequest)
  {
    string summarizationPrompt = $"""
      system:
      IDENTITY and PURPOSE
      You are an expert content summarizer. You take content in and output a Markdown formatted summary using the format below.

      OUTPUT INSTRUCTIONS
      Combine all of your understanding of the content into a single, {generateSummaryRequest.MaxNrOfWords}-word paragraph.
      Create the output using the formatting above.
      You only output human readable Markdown.
      
      INPUT:

      user:
      {generateSummaryRequest.Content}
      """
    ;

    string? summary = await _kernel.InvokePromptAsync<string>(summarizationPrompt);
    return summary;
  }
}
