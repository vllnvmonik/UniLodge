import { Request, Response } from "express";
import { UserType } from "../middlewares/token.authentication";
import {
  approveDormListing,
  declineDormListing,
} from "../services/admin.services";
import {
  validateDescriptionLength,
  validateRequiredFields,
} from "../utils/input.validators";

export const approveDormListingController = async (
  req: Request & { user?: UserType },
  res: Response
) => {
  try {
    const user = req.user;
    if (!user) return res.status(404).json({ error: "User not found" });
    const { dorm_id } = req.params;
    if (!dorm_id) return res.status(404).json({ error: "Dorm not found" });

    const dorm = await approveDormListing(dorm_id);
    if (dorm.httpCode === 200)
      return res.status(dorm.httpCode).json({ message: dorm.message });

    return res.status(dorm.httpCode).json({ error: dorm.error });
  } catch (error) {
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

export const declineDormListingController = async (
  req: Request & { user?: UserType },
  res: Response
) => {
  try {
    const user = req.user;
    if (!user) return res.status(404).json({ error: "User not found" });
    const { dorm_id } = req.params;
    if (!dorm_id) return res.status(404).json({ error: "Dorm not found" });

    const dorm = await declineDormListing(dorm_id);
    if (dorm.httpCode === 200)
      return res.status(dorm.httpCode).json({ message: dorm.message });

    return res.status(dorm.httpCode).json({ error: dorm.error });
  } catch (error) {
    return res.status(500).json({ error: "Internal Server Error" });
  }
};
