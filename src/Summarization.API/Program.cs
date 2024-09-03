using Azure.Identity;
using Microsoft.SemanticKernel;
using Summarization_API.Services;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddTransient<ISummaryService, TextSummaryService>();

builder.Services.AddAzureOpenAIChatCompletion(deploymentName: builder.Configuration["AzureOpenAI:ChatCompletionDeploymentName"]!, 
                                              endpoint: builder.Configuration["AzureOpenAI:ChatCompletionEndpoint"]!, 
                                              credentials: new DefaultAzureCredential());
builder.Services.AddKernel();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
