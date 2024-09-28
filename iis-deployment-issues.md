# Issue Found

## 1. Deploy to IIS - Incorrect Guidance Leading and Insufficient Information

### 3. Configure URL Rewrite for Client-Side Routing

Based on the setup, the rewrite URL was "/index.html". However, due to the source code in `vite.config.js`, which already points the base based on the `VITE_APP_BASE_NAME` in `.env` to "/demos", the URL Rewrite rules will not work. The correct rewrite URL should be "/demos/index.html", given that the website is hosted in a **subdirectory**.

### 4. Set Folder Permissions

What should be the steps, and which account needs to be set for the permissions?

    Ensure that the IIS_IUSRS group or create an APP pool to have read permissions to the folder.
        1. Right-click on the folder and select Properties.
        2. Go to the Security tab.
        3. Click Edit, then Add, and enter the account.
        4. Grant the necessary permissions (usually Read & Execute).

## 2. "base" in `vite.config.js`

**Default Behavior:** If a base is not specified, Vite uses the default value of '/'. This means that assets will be served from the root of the domain.

**Subdirectory Hosting:** If the application is hosted in a subdirectory (e.g., example.com/demo/), the base option should be set to '/demo/'. This will adjust asset paths accordingly.

### Suggestion

The `VITE_APP_BASE_NAME` should not be handled in `.env` since we do not know what the IIS setup will be based on the situation above (default or subdirectory). Therefore, it should be included inside the JSON call: `my-config.json`.