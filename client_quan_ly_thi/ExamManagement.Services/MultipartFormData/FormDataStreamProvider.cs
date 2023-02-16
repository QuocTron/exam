using System.Net.Http;
using System.Net.Http.Headers;

namespace ExamManagement.Services.MultipartFormData
{
    public class FormDataStreamProvider : MultipartFormDataStreamProvider
    {
        public FormDataStreamProvider(string rootPath) : base(rootPath) { }

        public override string GetLocalFileName(HttpContentHeaders headers)
        {
            if (headers?.ContentDisposition != null)
            {
                return headers
                    .ContentDisposition
                    .FileName.TrimEnd('"').TrimStart('"');
            }

            return base.GetLocalFileName(headers);
        }
    }
}
