import { trpc } from "../lib/trpc";
import { AttendanceRecord, CreateAttendanceRecordInput } from "../types";

export const useAttendance = (projectId: number) => {
  const utils = trpc.useUtils();

  const { data: attendanceRecords, isLoading, error } = trpc.attendance.listByProject.useQuery({ projectId });

  const createAttendanceRecordMutation = trpc.attendance.create.useMutation({
    onSuccess: () => {
      utils.attendance.listByProject.invalidate({ projectId });
    },
  });

  const createAttendanceRecord = async (recordData: CreateAttendanceRecordInput) => {
    return createAttendanceRecordMutation.mutateAsync(recordData);
  };

  return {
    attendanceRecords,
    isLoading,
    error,
    createAttendanceRecord,
  };
};
