import TestFileUploader from "@/app/_components/forms/fileUploader";
import TestFileView from "@/app/_layouts/fileView";

export default function Page() {
  return(
    <>
      <h1>S3 Test Page</h1>

      <hr />
      <div>
        <p>File Upload</p>
        <TestFileUploader />
      </div>

      <hr />
      <div>
        <p>File Download</p>
        <TestFileView prefix={''} />
      </div>
    </>
  )
}
