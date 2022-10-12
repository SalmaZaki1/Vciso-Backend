function PrivateRoute({ children, ...rest }) {
    const [isLoggedIn, setIsLoggedIn] = React.useState(null);
    const landingPath = useLocation();
  
    React.useEffect(() => {
      async function checkLoggedIn() {
        const token = localStorage.getItem("auth-token");
  
        if (token === null) {
          localStorage.setItem("auth-token", "");
          token = "";
        }
  
        const tokenRes = await Axios.post(
          "http://localhost:5000/users/tokenIsValid",
          null,
          { headers: { "x-auth-token": token } }
        );
  
        if (tokenRes.data) {
            const userRes = await Axios.get("http://localhost:5000/users/", {
            headers: { "x-auth-token": token },
          });
  
          setIsLoggedIn(true);
        } else {
          setIsLoggedIn(false);
        }
      }
    }, [])
  
    if (isLoggedIn === null) return null;
  
    return (
      <Route
        {...rest}
        render={() =>
          isLoggedin ? (
            children
          ) : (
            <Redirect
              to={{
                pathname: "/login",
                state: { from: landingPath.pathname },
              }}
            />
          )
        }
      />
    );
  }