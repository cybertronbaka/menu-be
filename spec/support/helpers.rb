def parsed
    JSON.parse(body).deep_symbolize_keys!
end

def sign_in(user, password = nil)
    post '/api/v1/users/sign_in', params: { user: { email: user.email, password: password || user.password }}
end

def sign_out
    delete '/api/v1/users/sign_out'
    cookies.delete('_session_id')
end

def expect_no_gql_errors
    expect(parsed[:errors]).to be_nil
end