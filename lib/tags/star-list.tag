<graphjs-star-list class={opts.minor != true && 'box'}>
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Login'}</div>
    </div>
    <div class="content">
        <div class="bar">
            <div class="search">
                <div class="icon">
                    <svg viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                            <path d="M20.7680925,17.4466286 C17.9916599,20.2182136 17.582728,24.4722742 19.5628195,27.6735622 L15.5811138,31.6483159 C14.8062954,32.4217814 14.8062954,33.6464353 15.5811138,34.4199008 C16.3559322,35.1933664 17.582728,35.1933664 18.3575464,34.4199008 L22.3177294,30.4666324 C25.5246166,32.4217814 29.7861178,32.0350486 32.5625504,29.2634637 C35.8124832,26.0192053 35.8124832,20.7338573 32.5625504,17.4681138 C29.3126177,14.1808851 24.0180253,14.1808851 20.7680925,17.4466286 Z M30.1304816,26.7926709 C28.2149583,28.7048497 25.094162,28.7048497 23.1786387,26.7926709 C21.2631154,24.8804921 21.2631154,21.7651447 23.1786387,19.8529659 C25.094162,17.9407872 28.2149583,17.9407872 30.1304816,19.8529659 C32.0460048,21.7866298 32.0460048,24.8804921 30.1304816,26.7926709 Z" id="Shape" transform="translate(25.000000, 25.000000) scale(-1, 1) translate(-25.000000, -25.000000) "></path>

                        </g>
                    </svg>
                </div>
                <input onkeyup={handleFilter} type="text" placeholder="Search web addresses..." />
            </div>
        </div>
        <div class="list">
            <div each={matchedStar in matchedStars} class="item" data-link="star" data-id={matchedStar} onclick={opts.minor ? handleCallback : handleShow} if={matchedStars.length > 0}>
                <div class={type + ' icon'}>
                    <svg if={type == 'default'} viewBox="0 0 62 58" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-19.000000, 0.000000)" d="M78.55,20.92 L60,18.22 L51.41,0.88 C51.1430837,0.342731823 50.5949178,0.00297581751 49.995,0.00297581751 C49.3950822,0.00297581751 48.8469163,0.342731823 48.58,0.88 L40,18.22 L21.43,20.92 C20.7357885,21.0320591 20.1641226,21.5260416 19.9525703,22.1966625 C19.7410179,22.8672834 19.9257511,23.5998777 20.43,24.09 L33.86,37.2 L30.64,56 C30.5260197,56.6400466 30.78705,57.289052 31.3124543,57.6719377 C31.8378586,58.0548234 32.535622,58.1045341 33.11,57.8 L50,48.92 L66.89,57.8 C67.464378,58.1045341 68.1621414,58.0548234 68.6875457,57.6719377 C69.21295,57.289052 69.4739803,56.6400466 69.36,56 L66.14,37.2 L79.58,24.1 C80.0914811,23.6064567 80.2769729,22.8645697 80.0579562,22.1883821 C79.8389395,21.5121946 79.2537111,21.0199434 78.55,20.92 Z"></path>
                    </svg>
                    <svg if={type == 'like'} viewBox="0 0 42 54" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-21.000000, 0.000000)" d="M62.973,24.929 C62.727,26.613 61.768,28.044 60.453,28.9 C60.152,29.099 59.844,29.372 59.515,29.619 L59.385,29.626 C60.631,31.886 60.487,33.536 59.042,35.693 C58.816,36.035 58.645,36.295 58.419,36.528 C59.74,39.253 58.994,42.499 56.666,44.327 C56.755,45.422 56.885,46.504 56.755,47.586 C56.399,50.729 54.099,52.92 50.778,53.31 C50.21,53.372 49.621,53.426 49.032,53.454 C48.635,53.475 48.224,53.488 47.813,53.495 C44.616,53.187 41.418,52.728 38.228,52.345 C35.25,51.996 32.285,51.489 29.088,50.955 C27.814,50.736 26.507,50.517 25.137,50.305 L25.137,50.305 C23.2995486,50.305 21.81,48.8154514 21.81,46.978 L21.81,30.584 C21.81,30.057 21.817,29.53 21.831,29.002 C21.831,28.858 21.838,28.714 21.838,28.571 C21.859,27.955 21.893,27.332 21.934,26.709 C22.064,24.648 25.275,24.429 26.597,23.827 C27.165,23.567 27.645,23.245 28.069,22.875 C28.24,22.731 28.404,22.574 28.562,22.416 C29.452,21.567 30.281,20.608 31.13,19.623 C31.349,19.377 31.561,19.123 31.774,18.884 C33.287,17.152 34.629,15.666 35.889,14.338 C36.587,13.599 37.183,12.791 37.683,11.901 C38.566,10.333 39.162,8.505 39.504,6.321 C39.689,5.123 39.853,3.808 39.997,2.322 C40.072,1.541 40.469,0.59 41.914,0.514 C43.229,0.452 44.495,0.822 45.591,1.507 C47.357,2.616 48.658,4.54 48.919,6.772 C49.124,8.497 48.905,10.23 48.221,12.386 C47.612,14.296 47.043,16.261 46.482,18.165 L46.044,19.671 L46.27,19.664 C48.146,19.568 50.022,19.472 51.898,19.37 C53.733,19.274 55.575,19.178 57.416,19.082 C57.614,19.075 57.813,19.062 58.012,19.048 C58.594,19.117 59.114,19.233 59.594,19.39 C59.772,19.445 59.93,19.513 60.08,19.582 C60.176,19.616 60.251,19.657 60.34,19.698 C60.402,19.732 60.463,19.78 60.518,19.814 C60.586,19.855 60.662,19.896 60.723,19.944 C60.798,20.006 60.874,20.054 60.935,20.108 C62.378,21.19 63.233,23.101 62.973,24.929 Z"></path>
                    </svg>
                    <svg if={type == 'love'} viewBox="0 0 81 71" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-10.000000, 0.000000)" d="M67.5,1 C61.5,1 56.7,3.2 52.4,7.4 C52.4,7.4 52.4,7.4 52.4,7.4 L50,10.4 L47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C43.4,3.3 38.5,0.9 32.5,0.9 C26.5,0.9 20.8,3.2 16.6,7.5 C12.4,11.7 10,17.4 10,23.4 C10,29.4 12.3,35.1 16.6,39.3 L46.5,69.4 C47.4,70.3 48.7,70.9 50.1,70.9 C51.4,70.9 52.7,70.4 53.7,69.4 L83.6,39.3 C87.8,35.1 90.2,29.4 90.2,23.4 C90.2,17.4 87.9,11.7 83.6,7.5 C79.2,3.3 73.5,1 67.5,1 Z"></path>
                    </svg>
                    <svg if={type == 'save'} viewBox="0 0 72 88" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-15.000000, 0.000000)" d="M86.291,44.172 L86.291,8.734 C86.291,4.069 82.525,0.303 77.86,0.303 L24.114,0.303 C19.463,0.303 15.683,4.069 15.683,8.734 L15.683,44.171 L15.682,44.171 L15.682,87.949 L50.987,69.682 L86.292,87.949 L86.291,44.172 Z"></path>
                    </svg>
                </div>
                <div if={scope == 'global'} class="count">
                    {starsData[matchedStar] && starsData[matchedStar].count}
                </div>
                <a class="title" href={starsData[matchedStar] && starsData[matchedStar].url}>
                    {starsData[matchedStar].title || starsData[matchedStar].url}
                </a>
                <a if={scope == 'user'} onclick={handleRemove} data-id={matchedStar} class="remove">
                    Delete
                </a>
            </div>
            <div class="placeholder item" if={matchedStars.length <= 0}>
                There isn't any star available.
            </div>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/star-list.less';
    </style>
    <script>
        import getStars from '../scripts/getStars.js';
        import getUserStars from '../scripts/getUserStars.js';
        import removeStar from '../scripts/removeStar.js';

        this.type = opts.type || 'default';
        this.scope = opts.scope || 'global';
        this.stars = [];
        this.starsData = {};
        this.matchedStars = [];

        this.on('before-mount', function() {
            this.handleContent();
        });

        this.handleContent = () => {
            let self = this;
            this.scope == 'user'
            ? getUserStars(function(response) {
                self.handleResponse(response);
            })
            : getStars(function(response) {
                self.handleResponse(response);
            });
        }
        this.handleResponse = (response) => {
            let self = this;
            if(response.success) {
                self.stars = [];
                for(let star of Object.keys(response.pages)) {
                    self.stars.push(star);
                    self.starsData[star] = {
                        url: star,
                        title: response.pages[star].title && unescape(response.pages[star].title),
                        count: response.pages[star].star_count
                    }
                }
                self.matchedStars = self.stars;
                self.update();
            } else {
                //Handle error
            }
        }
        this.handleFilter = (event) => {
            let self = this;
            self.matchedStars = self.stars.filter(item => self.starsData[item].url.includes(event.target.value));
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            removeStar(event.target.dataset.id, function(response) {
                if(response.success) {
                    self.handleContent();
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
    </script>
</graphjs-star-list>