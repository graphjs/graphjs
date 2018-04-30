<graphjs-messages-composer class={'root box' + (checked ? ' checked' : '')}>
    <div class="header">
        <div class="title">Send Message</div>
        <a class="option right" onclick={handleOverlay}>
            <svg viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-755.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
                </g>
            </svg>
        </a>
    </div>
    <div class={'content' + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')}>
        <div if={recipient} class={'recipient' + (recipient ? '' : ' unknown')}>{profile ? profile.username : 'No recipient'}</div>
        <form>
            <textarea ref="message" placeholder="Write your message here..."></textarea>
            <button onclick={handleMessage}>Send Message</button>
            <button onclick={handleClear} class="danger">Clear</button>
        </form>
        <div if={!loaded && !blocked} class="inline loader">
            <img src="lib/images/animations/loading-dots.gif">
        </div>
        <button if={blocked} onclick={handleBlock} class="blockage">Login to start a thread</button>
    </div>
    <div class="check">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark_circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="checkmark_check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/messages-composer.less';
    </style>
    <script>
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import sendMessage from '../scripts/sendMessage.js';
        import hideOverlay from '../scripts/hideOverlay.js';

        this.recipient = opts.to;
        this.loaded = false;

        this.on('before-mount', function() {
            this.handleUser();
        });
        this.on('mount', function() {
            this.refs.message.focus();
        });

        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.handleRecipient();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleRecipient = () => {
            let self = this;
            self.recipient && getProfile(self.recipient, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.loaded = true;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleMessage = (event) => {
            let self = this;
            event.preventDefault();
            let value = self.refs.message.value.replace(/\n+/g, '\n'); // Removes repetitive line breaks
            sendMessage(self.recipient, value, function(response) {
                if(response.success) {
                    self.checked = true;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.message.value = '';
            this.refs.message.focus();
        }
        this.handleOverlay = () => hideOverlay();
    </script>
</graphjs-messages-composer>