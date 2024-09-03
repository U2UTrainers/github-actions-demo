
namespace Summarization_API.Services;

public interface ISummaryService
{
  Task<string?> GenerateSummary(string content);
}