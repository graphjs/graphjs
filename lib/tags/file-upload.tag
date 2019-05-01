<graphjs-file-upload class={'graphjs-element graphjs-root ' + boxStyle}>
    <div>
        <div class="graphjs-header">
            <div class="graphjs-title">File Upload</div>
        </div>
        <div class='graphjs-content'>
            <input type="file"
               ref="fileUpload"
               class="filepond"
               name="filepond"
            />
            <graphjs-promo if={loaded} properties="bottom right" detach={opts.box === 'disabled'}></graphjs-promo>
        </div>
    </div>
    <script>
        import * as FilePond from 'filepond';
        import FilePondPluginImagePreview from 'filepond-plugin-image-preview';
        import FilePondPluginFileValidateType from 'filepond-plugin-file-validate-type';
        import FilePondPluginFileValidateSize from 'filepond-plugin-file-validate-size';

        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';
            
        const self = this;
        this.on('mount', function() {
            FilePond.registerPlugin(
                FilePondPluginImagePreview,
                FilePondPluginFileValidateType,
                FilePondPluginFileValidateSize
            );
            let accept = null;
            let maxFileSize = null
            if(opts.type === "video"){
                accept = "video/mp4,video/mpeg,video/avi,video/flv,video/wmv";
                maxFileSize = "20MB";
            } else if(opts.type === "photo"){
                accept = "image/jpeg,image/png,image/gif";
                maxFileSize = "5MB";
            } else if(opts.type === "file"){
                accept = "application/pdf,application/msword,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.openxmlformats-officedocument.wordprocessingml.template,application/vnd.ms-word.document.macroEnabled.12,application/vnd.ms-word.template.macroEnabled.12,application/vnd.ms-excel,application/vnd.ms-excel,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.openxmlformats-officedocument.spreadsheetml.template,application/vnd.ms-excel.sheet.macroEnabled.12,application/vnd.ms-excel.template.macroEnabled.12,application/vnd.ms-excel.addin.macroEnabled.12,application/vnd.ms-excel.sheet.binary.macroEnabled.12,application/vnd.ms-powerpoint,application/vnd.ms-powerpoint,application/vnd.ms-powerpoint,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/vnd.openxmlformats-officedocument.presentationml.template,application/vnd.openxmlformats-officedocument.presentationml.slideshow,application/vnd.ms-powerpoint.addin.macroEnabled.12,application/vnd.ms-powerpoint.presentation.macroEnabled.12,application/vnd.ms-powerpoint.template.macroEnabled.12,application/vnd.ms-powerpoint.slideshow.macroEnabled.12,application/vnd.ms-access";
                maxFileSize = "20MB";
            }
            var pond = FilePond.create(
            	this.refs.fileUpload,
            	{
            	   acceptedFileTypes: accept.split(","),
                   allowFileTypeValidation: true,
                   allowFileSizeValidation: true,
                   maxFileSize: (maxFileSize ? maxFileSize : "5MB"),
                   maxFiles: "1",
                   allowMultiple: false 
            	}
            );
        });
    </script>
</graphjs-file-upload>