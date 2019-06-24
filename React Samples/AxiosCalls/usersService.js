import axios from "axios";
import * as serviceHelper from "./serviceHelpers";

const url = serviceHelper.API_HOST_PREFIX;

const addUser = payload => {
  const config = {
    method: "POST",
    url: `${url}/api/users/register`,
    data: payload,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const updateUser = (payload, id) => {
  const config = {
    method: "PUT",
    url: `${url}/api/users/${id}`,
    data: payload,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const getUserById = id => {
  const config = {
    method: "GET",
    url: `${url}/api/users/${id}`,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const getUserDetails = email => {
  const config = {
    method: "GET",
    url: `${url}/api/users/details?email=${email}`,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const loginUser = payload => {
  const config = {
    method: "POST",
    url: `${url}/api/users/login`,
    data: payload,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const adminTotals = () => {
  const config = {
    method: "GET",
    url: `${url}/api/users/admin/stats`,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const usersTotalByMonth = year => {
  const config = {
    method: "GET",
    url: `${url}/api/users/monthly/count/${year}`,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const getUserByToken = token => {
  const config = {
    method: "GET",
    url: `${url}/api/users/token/${token}`,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const deactivateUser = id => {
  const config = {
    method: "PUT",
    url: `${url}/api/users/status/${id}`,
    withCredentials: true,
    crossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

export {
  addUser,
  updateUser,
  getUserById,
  loginUser,
  adminTotals,
  usersTotalByMonth,
  getUserDetails,
  getUserByToken,
  deactivateUser
};
