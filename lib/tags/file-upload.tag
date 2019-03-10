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
            var pond = FilePond.create(
            	this.refs.fileUpload,
            	{
                   acceptedFileTypes: (opts.accept ? opts.accept.split(",") : "image/*"),
                   allowFileTypeValidation: true,
                   allowFileSizeValidation: true,
                   maxFileSize: (opts.maxfilesize ? opts.maxfilesize : "5MB"),
                   maxFiles: "1",
                   allowMultiple: false 
            	}
            );
        });
    </script>
</graphjs-file-upload>