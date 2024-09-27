# Sample2 Project

## Technologies Used
- **Vite**: Fast build tool and dev server
- **React**: JavaScript library for building user interfaces
- **MUI (Material UI)**: UI components for faster and easier web development

### Installation

1. Clone the repository:

   ```bash
   cd client

2. Install dependencies

   ```bash
     npm install

3. Run project locally

   ```bash
   npm run dev

4. Build project

   ```bash
     npm run build

### Deploy to IIS

1. Install IIS (If Not Already Installed)
2. Create a New Website in IIS
3. Configure URL Rewrite for Client-Side Routing
    Set the following rule:
      - Match URL:
        * Requested URL: Matches the Pattern
        * Using: Regular Expressions
        * Pattern: ^.*$ (matches all requests)
      - Conditions: Add a condition to exclude static files:
        * Condition input: {REQUEST_FILENAME}
        * Check if input string: Does Not Match the Pattern
        * Pattern: .*\.(css|js|map|json|jpg|jpeg|png|gif|ico|svg|woff|woff2|eot|ttf)$
      - Action:
        * Action Type: Rewrite
        * Rewrite URL: /index.html
  
4. Set Folder Permissions



