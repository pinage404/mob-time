module Lib.Icons.Custom exposing (..)

import Html exposing (i)
import Html.Attributes exposing (class)
import Svg exposing (Svg, g, path, svg)
import Svg.Attributes exposing (d, enableBackground, height, id, viewBox, width)


tomato : Svg msg
tomato =
    display_
        [ path [ d "m461.071 161.081c-23.788 11.751-54.203 22.468-86.994 22.468-7.231 0-14.31-.509-21.219-1.562-14.004 42.828-30.147 83.89-64.403 94.551l-10.338 3.225-10.338-3.225c-34.255-10.66-50.399-51.723-64.403-94.551-6.909 1.052-13.987 1.562-21.202 1.562-6.975.002-13.756-.77-20.489-1.642-46.518 40.623-74.775 98.875-74.775 165.739 0 29.288 4.133 56.527 11.645 81.539-18.324-31.005-29.027-69.644-29.027-116.304 0-57.112 22.999-104.551 60.183-137.911-12.585-3.917-24.181-8.761-34.552-13.885-37.801 39.556-60.395 92.199-60.395 151.796 0 145.56 97.793 243.353 243.353 243.353s243.353-97.792 243.353-243.352c0-59.599-22.593-112.245-60.399-151.801z" ]
            []
        , path [ d "m69.53 104.294s84.739 69.529 156.441 34.765c11.95 34.765 27.523 96.619 52.147 104.294 24.624-7.675 40.197-69.529 52.147-104.294 71.702 34.765 156.441-34.765 156.441-34.765s-52.146-52.147-121.676-34.765c35.851-23.177 34.765-69.529 34.765-69.529s-121.676 20.279-121.676 69.529c0-49.25-121.677-69.529-121.677-69.529s-1.086 46.352 34.765 69.529c-69.53-17.382-121.677 34.765-121.677 34.765z" ]
            []
        ]


elephant : Svg msg
elephant =
    display_
        [ g []
            [ g []
                [ path [ d "m477.055 336.539c-20.432 0-37.055-16.623-37.055-37.055v-57.254c24.961-4.363 44-26.177 44-52.369v-52.644c0-29.323-23.855-53.178-53.178-53.178-11.761 0-23.088 3.917-32.292 10.951-21.705-19.245-50.24-30.951-81.461-30.951-18.48 0-36.268 7.247-49.502 20h-97.464c-22.705 0-44.466 5.071-64.677 15.074-4.95 2.45-6.977 8.448-4.527 13.398 1.744 3.524 5.287 5.567 8.971 5.567 1.489-.001 3.002-.335 4.428-1.04 17.429-8.625 36.204-12.999 55.806-12.999h34.05c-7.29 9.103-11.664 20.636-11.664 33.178v52.644c0 29.323 23.855 53.178 53.178 53.178 29.322 0 53.178-23.855 53.178-53.178 0-5.523-4.478-10-10-10s-10 4.477-10 10c0 18.294-14.884 33.178-33.178 33.178s-33.178-14.884-33.178-33.178v-52.644c0-18.294 14.884-33.178 33.178-33.178 10.595 0 20.305 4.883 26.641 13.398 3.297 4.43 9.56 5.351 13.992 2.053 4.431-3.297 5.35-9.562 2.053-13.992-1.984-2.666-4.211-5.109-6.624-7.329 9.493-9.012 22.171-14.13 35.341-14.13 56.754 0 102.929 46.174 102.929 102.931v112.514c0 31.46 25.595 57.055 57.055 57.055 8.283 0 15.023 6.739 15.023 15.022 0 9.086-7.392 16.478-16.478 16.478h-39.613c-43.4 0-79.619-31.316-87.259-72.538 6.68 2.281 13.83 3.538 21.272 3.538 16.542 0 30-13.458 30-30s-13.458-30-30-30c-3.309 0-6-2.691-6-6 0-16.542-13.458-30-30-30s-30 13.458-30 30c0 20.129 9.068 38.17 23.322 50.286.405 11.033 2.458 21.651 5.926 31.615-11.472 8.372-24.612 14.526-38.394 17.922-4.469 1.101-7.608 5.108-7.608 9.71v65.467h-44v-62c0-5.523-4.478-10-10-10h-111.142c-5.522 0-10 4.477-10 10v62h-44v-102.423c0-12.592-3.094-24.978-8.948-35.82-9.847-18.235-15.052-38.899-15.052-59.757 0-19.095 4.16-37.433 12.364-54.504 2.392-4.978.296-10.953-4.683-13.345-4.976-2.393-10.952-.297-13.345 4.682-8.277 17.225-13.001 35.554-14.089 54.596-14.066 4.205-24.351 17.258-24.351 32.674v101.896c0 5.523 4.478 10 10 10 5.523 0 10-4.477 10-10v-101.896c0-4.181 1.84-7.932 4.739-10.517 1.824 19.483 7.546 38.503 16.817 55.673 4.283 7.932 6.547 17.033 6.547 26.318v102.673c0 10.89 8.859 19.75 19.75 19.75h92.5c10.891 0 19.75-8.86 19.75-19.75v-52.25h43.142v52.25c0 10.89 8.859 19.75 19.75 19.75h92.49c10.891 0 19.75-8.86 19.75-19.75v-56.241c19.918 22.085 48.74 35.991 80.751 35.991h39.614c20.114 0 36.478-16.364 36.478-36.478-.001-19.311-15.712-35.022-35.023-35.022zm-64.56-226.973c5.385-3.568 11.75-5.527 18.327-5.527 18.294 0 33.178 14.884 33.178 33.178v52.644c0 15.11-10.158 27.885-24 31.877v-34.768c0-29.312-10.318-56.256-27.505-77.404zm-78.495 133.473c5.514 0 10 4.486 10 10 0 14.336 11.663 26 26 26 5.514 0 10 4.486 10 10s-4.486 10-10 10c-25.364 0-46-20.636-46-46 0-5.515 4.486-10 10-10zm-173.896 185h-28v-52h28zm147.141 0v-57.884c9.776-3.061 19.195-7.303 27.99-12.569v70.454h-27.99z", id "XMLID_956_" ]
                    []
                , path [ d "m357.945 189.108c1.87-1.86 2.931-4.44 2.931-7.07s-1.061-5.21-2.931-7.07c-1.859-1.86-4.43-2.93-7.069-2.93-2.63 0-5.21 1.07-7.07 2.93s-2.93 4.44-2.93 7.07 1.069 5.21 2.93 7.07c1.86 1.86 4.44 2.93 7.07 2.93 2.64.001 5.21-1.07 7.069-2.93z", id "XMLID_998_" ]
                    []
                , path [ d "m73.386 144.428c2.64 0 5.21-1.07 7.08-2.93 1.859-1.86 2.93-4.44 2.93-7.07s-1.07-5.21-2.93-7.07c-1.87-1.86-4.44-2.93-7.08-2.93-2.63 0-5.2 1.07-7.07 2.93-1.859 1.86-2.93 4.44-2.93 7.07s1.07 5.21 2.93 7.07c1.87 1.86 4.44 2.93 7.07 2.93z", id "XMLID_1001_" ]
                    []
                ]
            ]
        ]


rabbit : Svg msg
rabbit =
    display_
        [ g [ id "XMLID_71_" ]
            [ g [ id "XMLID_777_" ]
                [ g [ id "XMLID_132_" ]
                    [ path [ d "m483.75 207.457-12.658-18.279c-19.818-28.621-52.031-46.072-86.696-47.144l-133.672-133.673c-9.327-9.326-23.201-11.022-34.528-4.221-11.281 6.776-16.283 19.771-12.447 32.336 10.038 32.873 28.013 62.282 52.114 85.979l-66.691-17.87c-12.736-3.412-25.604 2.055-32.012 13.607-6.382 11.509-4.217 25.264 5.389 34.228 36.533 34.093 85.04 53.689 134.933 54.911-1.645 6.635-2.534 13.566-2.534 20.702 0 .48.029.954.036 1.433h-97.907c-21.371 0-41.908 4.655-61.041 13.835-4.98 2.389-7.079 8.363-4.689 13.342 1.72 3.584 5.296 5.677 9.022 5.677 1.45 0 2.924-.317 4.319-.986 16.41-7.874 34.037-11.867 52.389-11.867h100.573c9.549 37.115 43.298 64.621 83.351 64.621h45.006c-3.693 31.614-16.16 61.174-36.038 85.794v-10.211c0-5.523-4.478-10-10-10s-10 4.477-10 10v66.174c0 5.523 4.478 10 10 10 16.471 0 30.404 11.07 34.754 26.16h-58.238l-23.619-93.583c-1.352-5.355-6.79-8.601-12.144-7.249s-8.601 6.788-7.249 12.143l11.573 45.853c-9.518 4.084-19.378 7.273-29.481 9.529-6.674-5.513-14.635-9.52-23.363-11.485 1.024-6.361 1.234-12.837.627-19.358-3.626-38.849-35.976-69.28-73.648-69.28-20.989 0-40.736 7.776-55.605 21.897-15.156 14.394-23.504 33.786-23.504 54.602 0 13 3.253 25.249 8.969 35.998-32.104-21.839-53.232-58.665-53.232-100.335 0-17.866 3.792-35.067 11.271-51.126 2.331-5.007.163-10.956-4.844-13.287-5.01-2.331-10.957-.163-13.287 4.844-8.719 18.723-13.14 38.765-13.14 59.57 0 10.779 1.218 21.277 3.516 31.37-24.687 5.694-43.155 27.84-43.155 54.232 0 30.695 24.972 55.667 55.666 55.667 18.541 0 35.777-9.426 46.014-24.365 22.571 15.345 49.795 24.333 79.078 24.363.025 0 .049.002.074.002h109.014c5.522 0 10-4.477 10-10 0-9.456-2.358-18.369-6.504-26.196 6.955-1.944 13.79-4.295 20.482-7.033l9.004 35.676c1.121 4.441 5.116 7.553 9.696 7.553h77.435c5.522 0 10-4.477 10-10 0-27.555-19.946-50.539-46.16-55.268v-17.235c32.528-31.558 52.34-73.063 56.408-117.991 28.506-8.075 49.458-34.313 49.458-65.371 0-13.89-4.178-27.266-12.085-38.685zm-411.915 284.548c-19.666 0-35.666-16-35.666-35.667 0-17.39 12.512-31.903 29.004-35.034 7.986 20.76 20.73 39.177 36.902 53.897-6.441 10.252-17.878 16.804-30.24 16.804zm125.241 0c-.05 0-.099-.002-.148-.002-31.358-.04-56.857-25.563-56.857-56.93 0-31.682 25.964-56.499 59.109-56.499 27.456 0 51.059 22.462 53.734 51.138.731 7.84-.135 15.583-2.575 23.014-1 3.046-.479 6.388 1.401 8.985 1.881 2.597 4.894 4.135 8.1 4.135h.017c16.47 0 30.404 11.07 34.753 26.16h-97.534zm25.801-461.369c-1.719-5.629 2.334-8.58 3.616-9.351 1.302-.78 5.871-3.001 10.088 1.218l122.357 122.357c-2.997.796-5.925 1.758-8.785 2.861l-44.134-11.826c-40.092-23.583-69.61-60.942-83.142-105.259zm-46.683 107.163c-4.303-4.015-2.27-8.597-1.543-9.906.735-1.326 3.582-5.533 9.345-3.989l141.966 38.04c-8.443 7.044-15.521 15.668-20.773 25.419-47.534.713-94.274-17.16-128.995-49.564zm251.693 156.29h-46.886c-36.422 0-66.054-29.632-66.054-66.054s29.632-66.054 66.054-66.054c29.387 0 56.919 14.423 73.648 38.583l12.657 18.278c5.579 8.058 8.528 17.498 8.528 27.298.001 26.439-21.509 47.949-47.947 47.949z", id "XMLID_156_" ]
                        []
                    , path [ d "m400.172 209.005c-2.64 0-5.21 1.07-7.08 2.93-1.86 1.86-2.92 4.44-2.92 7.07s1.06 5.21 2.92 7.07c1.87 1.86 4.44 2.93 7.08 2.93 2.63 0 5.2-1.07 7.07-2.93 1.859-1.86 2.93-4.44 2.93-7.07s-1.07-5.21-2.93-7.07c-1.86-1.861-4.44-2.93-7.07-2.93z", id "XMLID_324_" ]
                        []
                    ]
                ]
            , g [ id "XMLID_70_" ]
                [ g [ id "XMLID_72_" ]
                    [ path [ d "m103.722 288.454c-2.63 0-5.21-1.07-7.07-2.93-1.859-1.86-2.93-4.44-2.93-7.07s1.07-5.21 2.93-7.07 4.44-2.93 7.07-2.93c2.64 0 5.21 1.07 7.07 2.93 1.859 1.86 2.93 4.44 2.93 7.07s-1.07 5.21-2.93 7.07-4.43 2.93-7.07 2.93z", id "XMLID_145_" ]
                        []
                    ]
                ]
            ]
        ]


display_ : List (Svg msg) -> Svg msg
display_ a =
    i [ class "icon" ]
        [ svg
            [ height "1.4em"
            , width "1.4em"
            , viewBox "0 0 512 512"
            , enableBackground "new 0 0 512 512"
            ]
            a
        ]


mobber : Svg msg
mobber =
    display_
        [ g []
            [ path
                [ d "M161.760 30.833 C 155.803 39.288,140.000 87.030,140.000 96.571 C 140.000 112.213,203.162 119.788,241.063 108.692 C 262.943 102.287,262.823 102.813,250.975 65.000 C 238.183 24.174,225.550 12.932,215.122 33.097 C 206.125 50.497,187.551 48.541,181.527 29.560 C 178.823 21.041,168.177 21.727,161.760 30.833 M135.357 121.939 C 129.092 138.264,146.809 144.507,200.000 144.717 C 247.718 144.905,263.333 140.023,263.333 124.914 C 263.333 120.378,262.958 116.683,262.500 116.703 C 262.042 116.723,254.167 119.056,245.000 121.889 C 223.226 128.616,176.506 128.641,155.000 121.935 C 145.833 119.077,138.119 116.723,137.857 116.703 C 137.594 116.683,136.469 119.039,135.357 121.939 M90.000 131.339 C 28.427 147.429,28.105 158.284,88.793 172.045 C 178.782 192.449,398.973 170.228,351.069 145.577 C 323.561 131.421,274.170 122.020,277.863 131.643 C 282.869 144.687,255.527 156.189,212.846 158.992 C 163.330 162.245,121.775 150.313,119.407 132.162 L 118.333 123.935 90.000 131.339 M123.317 199.167 C 123.163 284.515,239.994 304.433,270.021 224.178 C 281.991 192.187,274.534 176.284,259.508 201.753 C 245.326 225.788,203.333 224.591,203.333 200.152 C 203.333 193.692,196.553 196.602,192.894 204.632 C 183.779 224.638,140.000 223.760,140.000 203.571 C 140.000 199.563,130.437 190.000,126.429 190.000 C 124.726 190.000,123.326 194.125,123.317 199.167 M88.333 215.721 C 56.613 228.513,19.616 256.506,33.970 256.853 C 46.463 257.155,68.761 267.592,90.077 283.115 C 113.664 300.291,114.155 301.898,96.542 304.261 C 80.737 306.381,56.549 322.910,63.765 326.659 C 66.278 327.965,79.513 330.815,93.177 332.993 C 121.718 337.543,143.127 346.137,160.447 359.999 L 172.561 369.694 174.405 360.476 C 176.839 348.306,172.686 331.069,163.850 316.667 C 159.913 310.250,156.686 300.061,156.679 294.024 C 156.670 285.756,153.131 279.177,142.334 267.357 C 125.040 248.425,118.978 238.968,113.580 222.500 C 109.005 208.540,107.284 208.078,88.333 215.721 M286.593 215.833 C 286.451 227.200,273.815 249.398,256.779 268.209 C 246.128 279.971,240.249 289.173,241.426 292.242 C 242.476 294.977,238.834 307.467,233.334 319.999 C 218.497 353.804,220.929 376.210,237.747 360.658 C 253.465 346.123,279.821 336.694,327.745 328.462 C 348.223 324.944,321.164 303.462,295.966 303.234 L 285.000 303.134 300.000 289.924 C 318.795 273.371,351.149 256.695,364.699 256.577 L 375.000 256.487 363.333 246.559 C 336.268 223.528,286.746 203.700,286.593 215.833 M181.667 292.197 C 178.000 293.178,173.628 295.282,171.950 296.873 C 168.161 300.467,191.625 336.667,197.744 336.667 C 207.211 336.667,233.687 299.339,227.106 295.271 C 222.601 292.487,189.064 290.218,181.667 292.197 M188.536 359.167 C 187.334 364.208,185.570 370.958,184.617 374.167 C 183.140 379.140,185.191 380.000,198.525 380.000 L 214.167 380.000 212.083 369.583 C 210.938 363.854,210.000 357.104,210.000 354.583 C 210.000 345.060,190.930 349.132,188.536 359.167 "
                , id "path0"
                ]
                []
            ]
        ]


driver : Svg msg
driver =
    display_
        [ g []
            [ path
                [ d "M188.333 45.715 C 133.375 53.316,82.654 82.528,64.941 116.781 L 59.339 127.614 97.170 125.299 C 181.082 120.164,208.887 133.931,201.609 177.009 C 198.361 196.235,184.330 210.321,152.542 226.269 C 125.178 239.998,62.935 263.287,53.345 263.384 C 40.715 263.513,39.527 267.678,43.295 298.629 C 48.625 342.418,47.045 340.098,67.600 334.324 C 118.630 319.989,216.898 290.203,281.110 269.607 L 353.887 246.263 360.817 230.632 C 404.532 132.035,308.513 29.095,188.333 45.715 M75.055 144.167 C 57.872 195.212,44.638 249.994,49.499 249.949 C 59.486 249.856,61.852 245.430,77.971 196.667 C 86.759 170.083,94.686 146.458,95.586 144.167 C 96.682 141.375,93.796 140.000,86.840 140.000 C 81.130 140.000,75.826 141.875,75.055 144.167 M35.303 146.176 C 30.968 153.190,26.472 197.848,27.359 225.085 L 28.333 255.000 42.909 205.000 C 50.926 177.500,58.226 152.375,59.131 149.167 C 60.899 142.902,39.023 140.157,35.303 146.176 M152.183 149.429 C 140.044 162.843,149.459 183.333,167.762 183.333 C 178.263 183.333,190.000 172.777,190.000 163.333 C 190.000 146.552,163.579 136.837,152.183 149.429 M173.333 163.333 C 173.333 167.778,171.111 170.000,166.667 170.000 C 162.222 170.000,160.000 167.778,160.000 163.333 C 160.000 158.889,162.222 156.667,166.667 156.667 C 171.111 156.667,173.333 158.889,173.333 163.333 M265.000 288.820 C 228.333 300.632,165.672 319.767,125.752 331.341 C 85.833 342.915,52.083 353.540,50.752 354.953 C 41.913 364.338,160.401 334.473,240.000 307.252 C 330.244 276.392,334.526 274.755,335.917 270.581 C 337.693 265.254,339.968 264.669,265.000 288.820 "
                , id "path0"
                ]
                []
            ]
        ]


navigator : Svg msg
navigator =
    display_
        [ g []
            [ path
                [ d "M62.553 70.284 C 56.565 75.940,53.837 79.419,56.489 78.015 C 59.574 76.382,58.844 78.981,54.461 85.231 C 45.357 98.213,34.537 127.999,31.492 148.464 L 29.031 165.000 44.441 150.833 C 53.157 142.821,63.141 136.672,67.426 136.679 C 74.422 136.691,74.237 137.157,64.998 142.791 C 59.497 146.146,50.808 156.586,45.689 165.991 L 36.382 183.093 54.953 174.880 C 83.093 162.434,90.351 163.649,75.657 178.343 C 65.233 188.767,48.259 213.333,51.480 213.333 C 60.342 213.333,94.997 191.322,107.916 177.487 C 116.853 167.916,130.557 156.042,138.369 151.100 L 152.574 142.113 146.173 127.182 C 135.745 102.853,117.212 80.450,98.763 69.868 C 77.461 57.650,75.907 57.668,62.553 70.284 M149.465 160.234 C 142.754 163.691,125.504 179.623,111.131 195.638 C 64.625 247.460,54.785 256.205,38.324 260.350 C 21.116 264.683,21.043 265.486,35.188 295.000 C 56.017 338.460,71.105 344.859,114.463 328.619 C 175.675 305.693,216.623 305.349,281.086 327.223 C 332.957 344.824,347.252 338.069,369.886 285.265 C 378.845 264.366,378.957 264.701,361.584 260.327 C 345.226 256.208,335.307 247.383,288.849 195.617 C 274.466 179.591,256.841 163.490,249.683 159.838 L 236.667 153.198 236.667 163.417 C 236.667 201.169,170.158 202.732,163.614 165.133 L 161.667 153.949 149.465 160.234 M163.590 197.169 C 168.946 207.668,171.630 209.972,176.042 207.857 C 183.262 204.396,216.659 204.353,223.798 207.795 C 228.016 209.829,231.074 207.148,237.197 196.049 C 245.688 180.655,253.566 177.509,256.516 188.333 C 257.516 192.000,260.583 195.000,263.333 195.000 C 273.990 195.000,267.969 206.806,253.333 214.609 C 240.735 221.325,238.156 224.396,237.228 233.790 C 236.620 239.941,234.577 246.835,232.688 249.111 C 226.987 255.980,231.624 261.415,251.488 271.141 C 270.772 280.583,276.273 291.903,261.366 291.470 C 256.642 291.333,254.667 293.340,254.804 298.137 C 255.137 309.795,245.571 305.800,237.315 290.833 C 233.017 283.042,227.363 276.667,224.750 276.667 C 222.138 276.667,220.000 273.667,220.000 270.000 C 220.000 266.333,218.500 263.333,216.667 263.333 C 214.833 263.333,213.333 267.083,213.333 271.667 C 213.333 276.250,211.833 280.000,210.000 280.000 C 208.167 280.000,206.667 277.000,206.667 273.333 C 206.667 269.630,204.444 266.667,201.667 266.667 C 198.889 266.667,196.667 269.630,196.667 273.333 C 196.667 277.037,194.444 280.000,191.667 280.000 C 188.556 280.000,186.667 276.852,186.667 271.667 C 186.667 267.083,185.167 263.333,183.333 263.333 C 181.500 263.333,180.000 266.333,180.000 270.000 C 180.000 273.667,177.862 276.667,175.250 276.667 C 172.637 276.667,166.983 283.042,162.685 290.833 C 154.196 306.222,144.830 309.798,145.266 297.484 C 145.413 293.350,143.913 290.153,141.933 290.379 C 123.048 292.535,126.908 281.995,149.167 270.627 C 169.517 260.234,169.430 260.437,164.305 235.491 C 162.103 224.774,159.183 221.321,146.667 214.630 C 131.551 206.550,125.805 194.535,137.500 195.463 C 141.073 195.747,143.333 193.593,143.333 189.907 C 143.333 175.245,154.435 179.225,163.590 197.169 M170.000 234.883 C 170.000 243.100,183.199 248.229,189.117 242.312 C 195.896 235.533,191.710 230.000,179.803 230.000 C 173.416 230.000,170.000 231.701,170.000 234.883 M208.021 233.839 C 206.716 235.950,208.335 239.642,211.618 242.043 C 218.609 247.155,230.000 242.718,230.000 234.883 C 230.000 228.962,211.576 228.087,208.021 233.839 M196.667 251.667 C 196.667 254.417,198.870 256.667,201.562 256.667 C 204.544 256.667,205.708 254.712,204.539 251.667 C 203.483 248.917,201.281 246.667,199.643 246.667 C 198.006 246.667,196.667 248.917,196.667 251.667 "
                , id "path0"
                ]
                []
            ]
        ]
