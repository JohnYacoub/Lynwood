import axios from "axios";
import * as serviceHelper from "../services/serviceHelpers";

const url = serviceHelper.API_HOST_PREFIX;

const uploadFile = p => {
  const config = {
    method: "POST",
    url: `${url}/api/files/upload`,
    data: p,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const updateFile = p => {
  const config = {
    method: "PUT",
    url: `${url}/api/files/${p.id}`,
    data: p,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const getAllFiles = () => {
  const config = {
    method: "GET",
    url: `${url}/api/files`,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const getAllPaginated = (pageIndex, pageSize) => {
  const config = {
    method: "GET",
    url: `${url}/api/files/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const searchPaginated = (pageIndex, pageSize, query) => {
  const config = {
    method: "GET",
    url: `${url}/api/files/search?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const getFileById = Id => {
  const config = {
    method: "GET",
    url: `${url}/api/files/${Id}`,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

const deleteFile = Id => {
  const config = {
    method: "DELETE",
    url: `${url}/api/files/${Id}`,
    withCredentials: true,
    CrossDomain: true
  };
  return axios(config)
    .then(serviceHelper.onGlobalSuccess)
    .catch(serviceHelper.onGlobalError);
};

export {
  //   postFile,
  updateFile,
  getAllFiles,
  getFileById,
  deleteFile,
  uploadFile,
  getAllPaginated,
  searchPaginated
};
