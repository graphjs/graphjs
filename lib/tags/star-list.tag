<graphjs-star-list class="graphjs-element graphjs-root graphjs-box" style={
    (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
    (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
    (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
    (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
}>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Login'}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '') + (matchedStars.length > pageLimit ? ' graphjs-pagination' : '')}>
        <div if={loaded} class="graphjs-bar">
            <div class="graphjs-search">
                <div class="graphjs-icon">
                    <svg viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                            <path d="M20.7680925,17.4466286 C17.9916599,20.2182136 17.582728,24.4722742 19.5628195,27.6735622 L15.5811138,31.6483159 C14.8062954,32.4217814 14.8062954,33.6464353 15.5811138,34.4199008 C16.3559322,35.1933664 17.582728,35.1933664 18.3575464,34.4199008 L22.3177294,30.4666324 C25.5246166,32.4217814 29.7861178,32.0350486 32.5625504,29.2634637 C35.8124832,26.0192053 35.8124832,20.7338573 32.5625504,17.4681138 C29.3126177,14.1808851 24.0180253,14.1808851 20.7680925,17.4466286 Z M30.1304816,26.7926709 C28.2149583,28.7048497 25.094162,28.7048497 23.1786387,26.7926709 C21.2631154,24.8804921 21.2631154,21.7651447 23.1786387,19.8529659 C25.094162,17.9407872 28.2149583,17.9407872 30.1304816,19.8529659 C32.0460048,21.7866298 32.0460048,24.8804921 30.1304816,26.7926709 Z" transform="translate(25.000000, 25.000000) scale(-1, 1) translate(-25.000000, -25.000000)"></path>
                        </g>
                    </svg>
                </div>
                <input onkeyup={handleFilter} type="text" placeholder={content.searchPlaceholder}/>
            </div>
        </div>
        <div if={loaded} class="graphjs-list">
            <div each={matchedStar, index in matchedStars} class={'graphjs-item' + ((index + 1 > (page - 1) * pageLimit && index + 1 <= Math.min(matchedStars.length, page * pageLimit)) ? '' : ' graphjs-hidden')} data-link="star" data-id={matchedStar} onclick={opts.minor ? handleCallback : handleShow}>
                <div class={'graphjs-' + type + ' graphjs-icon' + (scope == 'global' ? ' graphjs-count' : '')}>
                    <div>
                        <span class="graphjs-icon">
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
                        </span>
                        <span if={scope == 'global'} class="graphjs-count">
                            {starsData[matchedStar] && starsData[matchedStar].count}
                        </span>
                    </div>
                </div>
                <a class="graphjs-title" href={starsData[matchedStar] && starsData[matchedStar].url}>
                    {starsData[matchedStar].title}
                </a>
                <a if={scope == 'user'} onclick={handleRemove} data-id={matchedStar} class="graphjs-remove">
                    <svg viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g transform="translate(-755.000000, -15.000000)" fill="black" fill-rule="nonzero">
                            <path d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
                        </g>
                    </svg>
                </a>
            </div>
            <div class="graphjs-placeholder graphjs-item" if={matchedStars.length <= 0}>
                {content.noStarText}
            </div>
        </div>
        <div class="graphjs-controls" if={matchedStars.length > pageLimit}>
            <a class={page == 1 ? 'graphjs-disabled' : ''} data-target="first" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-316.000000, -236.000000)" d="M320.8,294.640939 L321.4,294.640939 C324,294.640939 326.1,292.540939 326.1,289.940939 L326.1,270.140939 L367.6,294.040939 C370.7,295.840939 374.6,293.640939 374.6,290.040939 L374.6,240.640939 C374.6,237.040939 370.7,234.840939 367.6,236.640939 L326,260.540939 L326,240.740939 C326,238.140939 323.9,236.040939 321.3,236.040939 L320.7,236.040939 C318.1,236.040939 316,238.140939 316,240.740939 L316,290.040939 C316.1,292.540939 318.2,294.640939 320.8,294.640939 Z"></path>
                </svg>
            </a>
            <a class={page == 1 ? 'graphjs-disabled' : ''} data-target="previous" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-288.000000, -111.000000)" d="M289.5,139.023766 L337.3,111.423766 C339.3,110.223766 341.8,111.723766 341.8,114.023766 L341.8,169.223766 C341.8,171.523766 339.3,173.023766 337.3,171.823766 L289.5,144.223766 C287.5,143.023766 287.5,140.223766 289.5,139.023766 Z"></path>
                </svg>
            </a>
            <p>{'Displaying ' + parseInt(((page - 1) * pageLimit + 1), 10) + '-' + Math.min(matchedStars.length, parseInt(page * pageLimit, 10)) + ' of ' + matchedStars.length}</p>
            <a class={page == Math.ceil(matchedStars.length / pageLimit) ? 'graphjs-disabled' : ''} data-target="next" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-218.000000, -205.000000)" d="M270.5,238.223766 L222.7,265.823766 C220.7,267.023766 218.2,265.523766 218.2,263.223766 L218.2,208.023766 C218.2,205.723766 220.7,204.223766 222.7,205.423766 L270.5,233.023766 C272.5,234.223766 272.5,237.023766 270.5,238.223766 Z"></path>
                </svg>
            </a>
            <a class={page == Math.ceil(matchedStars.length / pageLimit) ? 'graphjs-disabled' : ''} data-target="last" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-172.000000, 0.000000)" d="M225.7,0.140939378 L225.1,0.140939378 C222.5,0.140939378 220.4,2.24093938 220.4,4.84093938 L220.4,24.6409394 L179,0.640939378 C175.9,-1.15906062 172,1.04093938 172,4.64093938 L172,54.1409394 C172,57.7409394 175.9,59.9409394 179,58.1409394 L220.5,34.2409394 L220.5,54.0409394 C220.5,56.6409394 222.6,58.7409394 225.2,58.7409394 L225.8,58.7409394 C228.4,58.7409394 230.5,56.6409394 230.5,54.0409394 L230.5,4.84093938 C230.4,2.24093938 228.3,0.140939378 225.7,0.140939378 Z"></path>
                </svg>
            </a>
        </div>
        <div if={!loaded} class={'graphjs-placeholder graphjs-loader' + (scope == 'user' ? ' graphjs-tight' : '')}>
            <div class="graphjs-bar graphjs-rectangle graphjs-fill"></div>
            <div class="graphjs-list">
                <div class="graphjs-item">
                    <div class="graphjs-icon graphjs-line graphjs-fill"></div>
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-icon graphjs-line graphjs-fill"></div>
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-icon graphjs-line graphjs-fill"></div>
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-icon graphjs-line graphjs-fill"></div>
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-icon graphjs-line graphjs-fill"></div>
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-icon graphjs-line graphjs-fill"></div>
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                </div>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{content.loginButtonText}</button>
    </div>
    <a class="graphjs-promo graphjs-bottom graphjs-right" href="https://graphjs.com" target="_blank">
        <svg viewBox="0 0 200 76" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g transform="translate(-620.000000, -18.000000)">
                <path fill="white" d="M674.455446,35.7851486 C670.318365,35.8917598 667.03137,36.6380379 667.03137,41.2223178 L667.03137,57.4805195 L657.623762,57.4805195 L657.623762,27.8959229 L666.464646,27.8959229 L666.464646,31.0409521 L666.577991,31.0409521 C668.221489,28.0025341 670.828416,26.8831169 674.455446,26.8831169 L674.455446,35.7851486 Z M708.118812,57.4555529 L698.942919,57.4555529 L698.942919,54.2598279 L698.832366,54.2598279 C697.174072,57.2957666 693.194167,58.4675325 689.877579,58.4675325 C680.425304,58.4675325 674.455446,51.4369374 674.455446,42.6486936 C674.455446,34.0202361 680.646409,26.8831169 689.877579,26.8831169 C693.249443,26.8831169 697.008243,28.1081448 698.832366,31.0375594 L698.942919,31.0375594 L698.942919,27.8950965 L708.118812,27.8950965 L708.118812,57.4555529 Z M699.207921,42.1556606 C699.207921,37.9181313 696.044608,34.7792208 691.701755,34.7792208 C687.358902,34.7792208 684.356436,38.127392 684.356436,42.2602909 C684.356436,46.2885595 687.573364,49.5844156 691.75537,49.5844156 C696.098224,49.5844156 699.207921,46.3408747 699.207921,42.1556606 Z M746.732673,42.9848228 C746.732673,51.2489434 740.703414,58.5000428 731.659524,58.5000428 C727.974977,58.5000428 724.848694,57.4337046 722.336502,54.8211762 L722.336502,67.3506494 L713.069307,67.3506494 L713.069307,27.8961381 L721.778238,27.8961381 L721.778238,31.1484694 L721.945717,31.1484694 C724.346256,28.2693565 727.807497,26.8831169 731.603698,26.8831169 C741.205852,26.8831169 746.732673,34.4008008 746.732673,42.9848228 Z M736.831683,42.2079758 C736.831683,38.0750769 733.46962,34.7792208 728.910891,34.7792208 C724.352162,34.7792208 720.990099,38.0750769 720.990099,42.2079758 C720.990099,46.2885595 724.409146,49.5844156 728.910891,49.5844156 C733.412636,49.5844156 736.831683,46.2885595 736.831683,42.2079758 Z M777.425743,57.4805195 L768.152664,57.4805195 L768.152664,41.3681994 C768.152664,38.1670762 767.203019,35.1793612 763.180993,35.1793612 C759.158967,35.1793612 757.985876,37.6869077 757.985876,41.048087 L757.985876,57.4805195 L748.712871,57.4805195 L748.712871,18 L757.985876,18 L757.985876,30.5910846 L758.097599,30.5910846 C759.717582,27.8167778 762.957547,26.8564409 766.08579,26.8564409 C769.102309,26.8564409 772.509859,27.8701299 774.520872,30.1109161 C777.48153,33.3653914 777.425669,36.8866269 777.425669,40.9413829 L777.425743,57.4805195 Z M781.386139,58.4675325 L781.386139,54.5194805 L785.346535,54.5194805 L785.346535,58.4675325 L781.386139,58.4675325 Z M784.536438,67.3506494 C783.67726,67.3506494 786.268605,67.3506494 784.523089,67.3506494 L784.523089,64.7049266 C786.093872,64.7049266 783.861369,64.7049266 784.536438,64.7049266 C786.745755,64.7049266 788.280003,63.3219351 788.280003,60.4356921 L788.280003,26.8831169 L791.287129,26.8831169 L791.287129,60.2553019 C791.287129,65.065707 788.586853,67.3506494 784.536438,67.3506494 Z M788.316832,23.9220779 L788.316832,18 L791.287129,18 L791.287129,23.9220779 L788.316832,23.9220779 Z M809.137199,58.4675325 C804.569886,58.4675325 799.570528,56.6238667 796.237624,53.9198236 L798.027517,51.5230581 C801.483863,54.1656457 805.310531,55.6405783 809.322361,55.6405783 C813.581072,55.6405783 816.913977,53.3052683 816.913977,49.6793923 L816.913977,49.5564813 C816.913977,45.8691497 812.963868,44.5171282 808.581715,43.2880176 C803.458917,41.813085 797.780635,40.2766969 797.780635,34.6842441 L797.780635,34.561333 C797.780635,29.5219799 802.039347,25.8961039 808.149672,25.8961039 C811.91462,25.8961039 816.173332,27.2481255 819.321075,29.3376133 L817.716343,31.8572899 C814.815482,29.9521686 811.359136,28.7230581 808.026231,28.7230581 C803.705799,28.7230581 800.866658,31.058368 800.866658,34.1925999 L800.866658,34.3155109 C800.866658,37.8184759 805.12537,39.1090419 809.630963,40.3996079 C814.692041,41.813085 820,43.6567508 820,49.1877481 L820,49.3106592 C820,54.903112 815.185804,58.4675325 809.137199,58.4675325 Z M644.223506,27.5368478 L649.921683,21.9480519 L656.12137,28.0287315 L650.410346,33.6301281 C653.873285,39.6947521 652.97562,47.5094104 647.71735,52.6667441 C646.76394,53.601852 645.72146,54.3963545 644.616695,55.0502516 L646.554631,62.1438924 C653.64101,62.234779 660.092324,66.9045865 662.016984,73.9496353 C664.337851,82.4449639 659.197676,91.1771075 650.536082,93.453424 C641.874487,95.7297404 632.971443,90.6882349 630.650576,82.1929063 C628.719812,75.1255165 631.952703,67.8942312 638.080998,64.3523626 L636.162765,57.3308403 C632.032091,57.3125692 627.90717,55.7578705 624.755545,52.6667441 C618.414818,46.4477319 618.414818,36.364721 624.755545,30.1457088 C630.03049,24.9720204 638.031978,24.1024 644.223506,27.5368478 Z M648.15907,84.8628715 C652.119469,83.8049934 654.469746,79.7468828 653.408561,75.7988279 C652.347375,71.850773 648.276576,69.5078218 644.316177,70.5656999 C640.355778,71.6235781 638.005501,75.6816886 639.066687,79.6297435 C640.127873,83.5777984 644.198671,85.9207496 648.15907,84.8628715 Z M631.085841,46.429232 C633.985774,49.3201261 638.687494,49.3201261 641.587427,46.429232 C644.487359,43.5383379 644.487359,38.8512725 641.587427,35.9603784 C638.687494,33.0694843 633.985774,33.0694843 631.085841,35.9603784 C628.185908,38.8512725 628.185908,43.5383379 631.085841,46.429232 Z"></path>
            </g>
        </svg>
    </a>
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
        import showLogin from '../scripts/showLogin.js';

        import TagsContent from '../content';
        let content = TagsContent[window.GraphJSConfig.language]['star-list'];
        content = {...content,...opts}
        this.content = content;
        
        this.type = opts.type || 'default';
        this.scope = opts.scope || 'global';
        this.page = 1;
        this.pageLimit = opts.pageLimit || 10;
        this.stars = [];
        this.starsData = {};
        this.matchedStars = [];

        this.on('before-mount', function() {
            this.handleContent();
        });

        this.restart = () => {
            this.handleContent();
        }
        this.handleContent = () => {
            let self = this;
            this.scope == 'user'
            ? getUserStars(function(response) {
                self.handleResponse(self.scope, response);
            })
            : getStars(function(response) {
                self.handleResponse(self.scope, response);
            });
        }
        this.handleResponse = (scope, response) => {
            let self = this;
            if(response.success) {
                self.stars = [];
                for(let star of Object.keys(response.pages)) {
                    self.stars.push(star);
                    self.starsData[star] = {
                        url: star,
                        title: response.pages[star].title ? unescape(response.pages[star].title) : star,
                        count: response.pages[star].star_count
                    }
                }
                if(scope == 'global') {
                    self.stars = Object.values(self.starsData).sort(function(a, b) {
                        return b.count - a.count;
                    }).map(item => item.url);
                }
                self.matchedStars = self.stars;
                self.loaded = true;
                self.update();
            } else {
                self.loaded = false;
                self.blocked = true;
                self.update();
                //Handle error
            }
        }
        this.handleFilter = (event) => {
            let self = this;
            self.matchedStars = self.stars.filter(item => self.starsData[item].title.toLowerCase().includes(event.target.value.toLowerCase()));
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm(content.removeConfirmationText)) {
                event.target.parentNode.parentNode.removeChild(event.target.parentNode);
                removeStar(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.handleContent();
                    } else {
                        //Handle error
                    }
                });
            }
        }
        this.handlePagination = (event) => {
            let self = this;
            let target = event.target.dataset.target;
            let lastPage = Math.ceil(self.matchedStars.length / self.pageLimit);
            switch(target) {
                case 'first':
                    self.page = 1;
                    break;
                case 'previous':
                    self.page = self.page == 1 ? 1 : self.page - 1;
                    break;
                case 'next':
                    self.page = self.page == lastPage ? lastPage : self.page + 1;
                    break;
                case 'last':
                    self.page = lastPage;
                    break;
            }
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateStarList'
            });
        }
    </script>
</graphjs-star-list>