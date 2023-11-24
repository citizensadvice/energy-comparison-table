# Analytics

## Google Analytics

Google Analytics 4 is added via Google Tag Manager and is loaded on all pages.

## Google Tag Manager

[Google Tag Manager](https://developers.google.com/tag-platform/tag-manager/web) is loaded on all pages.

There is a script loaded in the `<head>` at [shared/\_head_analytics.html.haml](../app/views/shared/_head_analytics.html.haml) and a `<noscript>` variant loaded in the `<body>` at [shared/\_google_tag_manager_no_script.html.haml](../app/views/shared/_google_tag_manager_no_script.html.haml).
