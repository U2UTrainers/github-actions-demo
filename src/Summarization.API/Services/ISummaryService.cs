
using Summarization_API.Requests;

namespace Summarization_API.Services;

public interface ISummaryService
{
  Task<string?> GenerateSummary(GenerateSummaryRequest generateSummaryRequest);
}