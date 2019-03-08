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
               multiple
               data-max-file-size="3MB"
               data-max-files="1" 
            />
            <graphjs-promo if={loaded} properties="bottom right" detach={opts.box === 'disabled'}></graphjs-promo>
        </div>
    </div>
    <script>
        import * as FilePond from 'filepond';
        import FilePondPluginImagePreview from 'filepond-plugin-image-preview';
        
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';
            
        const self = this;
        this.on('mount', function() {
            FilePond.registerPlugin(
                FilePondPluginImagePreview
            );
            var pond = FilePond.create(
            	this.refs.fileUpload
            );
        });
    </script>
</graphjs-file-upload>