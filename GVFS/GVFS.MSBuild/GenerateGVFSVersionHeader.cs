using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;
using System.IO;

namespace GVFS.MSBuild
{
    public class GenerateGVFSVersionHeader : Task
    {
        [Required]
        public string Version { get; set; }

        [Required]
        public string OutputFile { get; set; }

        public override bool Execute()
        {
            this.Log.LogMessage(MessageImportance.Normal,
                "Creating GVFS version header file with version '{0}' at '{1}'...",
                this.Version, this.OutputFile);

            string outputDirectory = Path.GetDirectoryName(this.OutputFile);
            if (!Directory.Exists(outputDirectory))
            {
                Directory.CreateDirectory(outputDirectory);
            }

            string template =
@"/*
 * This file is auto-generated by GVFS.MSBuild.GenerateGVFSVersionHeader.
 * Any changes made directly in this file will be lost.
 */
#define GVFS_FILE_VERSION {1}
#define GVFS_FILE_VERSION_STRING ""{0}""
#define GVFS_PRODUCT_VERSION {1}
#define GVFS_PRODUCT_VERSION_STRING ""{0}""
";

            File.WriteAllText(
                this.OutputFile,
                string.Format(
                    template,
                    this.Version,
                    this.Version?.Replace('.',',')));

            return true;
        }
    }
}