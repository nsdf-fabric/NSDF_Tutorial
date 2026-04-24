# NSDF Tutorial Codespaces Errors

This Google Docs document describes the possible error with the NSDF tutorial using Codespaces.

---

## Max Number of Codespaces Error

**Error:**
> You have reached the maximum number of running codespaces.

**Solution:**  
Go to [https://github.com/codespaces](https://github.com/codespaces)  
Delete old codespaces and wait for a few minutes.

---

## Dev Configuration Error

**Error:**  
> codespace was not built properly; run ‘build’ or docker error

### Solution 1: Relaunch Codespace
1. Exit the codespace  
2. Set the region to **‘US EAST’**  
3. Rerun the codespace

### Solution 2: Trigger Action
If the first solution doesn’t work, try pushing dummy commits to trigger the action workflow. This will build a new Docker container and push it. It should take approximately 6 minutes.

> ⚠️ Note: If you rerun the submitted action/jobs, it may or may not work (50-50 in my experience). So, it's better to submit a new one.  
> Close the codespaces and start a new one.

---

## Sharing Access Without GitHub or Slides

If users don't have access to the PDF slide or GitHub link:

- Use [TinyURL](https://tinyurl.com/) to shorten the URL
- Share the shortened link using the projector on the big screen
