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
               data-max-files="3" 
            />
            <graphjs-promo if={loaded} properties="bottom right" detach={opts.box === 'disabled'}></graphjs-promo>
        </div>
    </div>
    <script>
        import * as FilePond from 'filepond';
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';
        this.on('mount', function() {
            console.log(this.refs.fileUpload);
            FilePond.setOptions({
                server: {
                    url:window.GraphJSConfig.host,
                    process: {
                        url:'/uploadFile',
                        withCredentials: true,
                        onload:function(response){
                            console.log(response)
                        }
                    }
                }
            });
            FilePond.create(
            	this.refs.fileUpload
            );
            
        });
    </script>
</graphjs-file-upload>